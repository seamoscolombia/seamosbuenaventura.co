import PropTypes from 'prop-types';
import React from 'react';
import shouldUpdate from 'recompose/shouldUpdate';
import Tag from './tag';

const SelectInterests = ({ tags, action, returnToMySubjects }) => (
    <section id='select-tags-component'>
      <div className='flex-container tags-box'>
        { tags.map(tag => (
            <Tag 
              key={tag.id} 
              action={action} 
              {...tag} 
              selectedTagClass={tag.selected ? 'tagIsSelected' : 'tagIsNotSelected'}
            />
          ))
        }
      </div>
      <button className='btn' onClick={returnToMySubjects}> regresar </button>
    </section>
);

SelectInterests.propTypes = {
  tags: PropTypes.array.isRequired
};

const checkPropsChange = (props, nextProps) => 
    (nextProps.tags !== props.tags 
    || nextProps.tags.length !== 0);
    

export default shouldUpdate(checkPropsChange)(SelectInterests);
