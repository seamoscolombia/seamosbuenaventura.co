// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import ProfileButton from '../components/profile/profileButton';

const mapStateToProps = (state) => {
    const { user } = state;
    return { user };
};
class ProfileButtonContainer extends Component {
    goToProfile() {
        // this.props.history.push('/profile');
    }
    render() {
        return (<ProfileButton
            action={this.goToProfile.bind(this)}
            className={'nav-fb nav-fb-profile'}
            name={'Perfil'}
            user={this.props.user}
        />);
    }
}

export default connect(mapStateToProps)(ProfileButtonContainer);