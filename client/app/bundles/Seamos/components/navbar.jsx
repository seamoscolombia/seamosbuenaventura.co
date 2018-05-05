import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';
import GoogleLog from '../containers/googleLoginContainer';
import FacebookLogin from '../containers/facebookLoginContainer';
import ProfileButton from '../containers/profileButtonContainer';
import LogoutButton from '../containers/logoutButtonContainer';
import { S3_BASE } from '../constants';

const Menu = () => (
  [<li key='1' >
    <ProfileButton />
  </li>,
  <li key='2' >
    <LogoutButton />
  </li>]
);

function profile() {
    return (
      <span>
        <li style={{ display: 'inline-block' }} key='3'>
          <ProfileButton />
        </li>
      </span>
    );
}

function logout() {
    return (
      <li key='4'>
        <LogoutButton />
      </li>
    );
}

const Navbar = ({ session, user }) => (
  <header
    id='navbar-client'
    className='navbar navbar-fixed-top'
    role='banner'
  >
    <div id="client-navbar">
      <div className='navbar-header'>
        <Link to='/' className='navbar-brand'>
          <div id='brand-logo' />
        </Link>
        <div className='hide-on-desktop only-photo'>
          {session.logged && Object.keys(user).length !== 0 ?
            profile() :
            <div>
            </div>
          }
        </div>
        <button
          className='navbar-toggle pull-right'
          data-toggle='collapse-side'
          data-target='.side-collapse'
          data-target-2='.side-collapse-container'
          type='button'
          style={{ top: '0' }}
        >
          <span className='icon-bar' />
          <span className='icon-bar' />
          <span className='icon-bar' />
        </button>
      </div>

      <div className='navbar-transparent side-collapse in'>
        <nav className='navbar-collapse' role='navigation'>
          <ul className='nav navbar-nav navbar-right navbar-options'>
            <div className='hide-on-desktop login-buttons'>
              {session.logged && Object.keys(user).length !== 0 ?
                profile() :
                <div>
                  <li key='5'>
                    <FacebookLogin fbclassName='loginBtn loginBtn--facebook' fbText='Continuar con Facebook' />
                  </li>
                  <li key='6'>
                    <GoogleLog googleClassName='loginBtn loginBtn--google' googleText='Continuar con Google' />
                  </li>
                </div>
              }
            </div>
            <li key='7'>
              <a href='http://sifuerapresidente.co' target='_blank' rel='noopener noreferrer'> SIFUERAPRESIDENTE </a>
            </li>
            <li id='this' key='8'><a>Quienes somos</a></li>
            <li key='9'>
              <a
              href="https://seamosit.github.io"
              rel='noopener noreferrer'
              > Blog
              </a>
            </li>
            <li key='10'><Link to='/tags'> Temas </Link></li>
            <li key='11' id='politicians-link'><Link to='/politicians'> Concejales </Link></li>
            <div className='hide-on-mobile'>
              {session.logged && Object.keys(user).length !== 0 ?
                profile() :
                <li className="dropdown">
                  <button className="nav-with-background" type="button" data-toggle="dropdown">
                    REGÍSTRATE
                    <span className="caret"></span>
                  </button>
                  <ul className="dropdown-menu custom--dropdown">
                    <li>
                      <FacebookLogin fbclassName='loginBtn loginBtn--facebook' fbText='Continuar con Facebook' />
                    </li>
                    <li role="presentation" className="divider"></li>
                    <li>
                      <GoogleLog googleClassName='loginBtn loginBtn--google' googleText='Continuar con Google' />
                    </li>
                  </ul>
                </li>
              }
            </div>
            {session.logged && Object.keys(user).length !== 0 ?
              logout() : <span />
            }
          </ul>
        </nav>
      </div>
    </div>
  </header>
);

Navbar.propTypes = {

};

export default Navbar;
