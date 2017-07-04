// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';

import Profile from '../components/profile';
import { getUser, updateInterestsShow } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { user, interests } = state;
    return { user, interests };
};

const mapDispatchToProps = { getUser, updateInterestsShow };

class ProfileContainer extends Component {

    componentDidMount() {
        this.props.getUser();
    }
        
    goToEdit() {
        this.props.updateInterestsShow();
    }
  shouldComponentUpdate(nextProps, nextState) {
        if (Object.keys(nextProps.user).length === 0) {
            this.props.history.push('/');
            return false;
        } 
        return true;
    }

    
    render() {
        if (Object.keys(this.props.user) !== 0) {
            return <Profile {...this.props} goToEdit={this.goToEdit.bind(this)} />;
        }
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default withRouter(connect(mapStateToProps, mapDispatchToProps)(ProfileContainer));