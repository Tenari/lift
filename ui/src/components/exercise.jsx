import React from 'react';

export function Exercise({ex}) {
  console.log(ex)
  return <div className="bg-white rounded-xl shadow-lg p-2 w-1/5 m-2">
    {ex.name}
    <img src={ex.img} className="max-h-36"/>
  </div>
}

