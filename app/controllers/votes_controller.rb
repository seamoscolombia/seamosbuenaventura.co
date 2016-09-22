class VotesController < ApplicationController
  include SessionsHelper
  before_action :validate_session
  before_action :set_poll


  def yes
    vote("yes")
  end

  def no
    vote("no")
  end

  def blank
    vote("blank")
  end


  private

    def vote(code)
      vote_type = nil
      @poll.transaction do
        if !@poll.private?
          vote_type = VoteType.find_by(code: code)
        else
          totals = eval(@poll.totals)
          totals[code.to_sym] += 1
          @poll.totals = totals
          @poll.save!
        end
        vote = current_user.votes.build(
            poll_id: @poll.id,
            vote_type: vote_type
        )
        vote_save vote
      end
    rescue ActiveRecord::RecordInvalid
      error_msg = "#{I18n.t(:accion_no_realizada)} "
      error_msg += vote.errors.messages[:base].join(" ") unless vote.errors.messages[:base].nil?
      flash[:danger] = " #{error_msg}"
      redirect_to polls_path
    end

    def set_poll
      @poll = Poll.find_by(id: params[:vote][:poll_id])
      if @poll.nil?
        flash[:danger] = t(".poll_does_not_exist")
        redirect_to polls_path
      end
    end

    def vote_save(vote)
      if vote.save!
        redirect_to polls_path
      end
    end

end