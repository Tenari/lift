import React from 'react';
import {styles} from '../assets/style_config';

export const FilterBtn = ({setEq, eq, value, label}) => {
  return <button
    className={styles.goodBlankFn(eq === value) + styles.smbtn}
    onClick={() => (eq === value ? setEq(false) : setEq(value))}>
    {label}
  </button>;
};
