import React from 'react';

export function NavLink({set, page, label}) {
  return <button className="bg-white rounded-xl shadow-lg p-2" onClick={()=>set(page)}>{label || page}</button>
}
