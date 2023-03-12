import React from 'react';

export const FilterBtn = ({setEq, eq, value, label}) => {
  const defaultFilterButton = " p-1 rounded-sm m-1";
  return <button
    className={(eq === value ? "bg-green-200" : "bg-white") + defaultFilterButton}
    onClick={() => (eq === value ? setEq(false) : setEq(value))}>
    {label}
  </button>;
};
