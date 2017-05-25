// Simple example of a React "smart" component
import React, {Component} from 'react';
import { connect } from 'react-redux';
import Tags from '../components/Tags';
import { getTags } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { tags } = state;
    return { tags };
};

const mapDispatchToProps = { getTags };

class TagsContainer extends Component {

    componentWillMount(){
        this.props.getTags();
    }

    render() {
        const { tags } = this.props;
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(TagsContainer);
