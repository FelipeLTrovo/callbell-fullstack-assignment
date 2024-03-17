import React from 'react';
import Button from './Button.jsx';


function Navbar(props){
  return(
    <div className="rounded shadow-2xl h-10 w-full row-start-1 fixed">
      <Button label="+ New List" toolTip="Add a new list to the board" style="text-gray-400 row-start-6 col-start-2 hover:bg-green-700 w-full h-8 absolute"  actionEvent="new_list" />
    </div>
  );
}
export default Navbar