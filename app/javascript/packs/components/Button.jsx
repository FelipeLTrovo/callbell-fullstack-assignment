import React from 'react';
import axios from "axios";


function Button(props){
  const handleDelete = async () => {
    try {
      await axios.delete(`http://localhost:3000/api/v1/cards/${props.cardId}`, {data: {id: props.cardId}});
    } catch (error) {
      console.error("Error deleting card :", error);
    }
  };

  const handleInsert = async () => {
    try {
      await axios.post('http://localhost:3000/api/v1/cards/', 
                        {card:
                          {
                            name: 'New card created via front end',
                            desc: 'New card description created via front end',
                            list_id: `${props.listId}`
                          }
                        }
                      );
    } catch (error) {
      console.error("Error inserting card:", error);
    }
  };

  const handleNewList = async () => {
    try {
      await axios.post('http://localhost:3000/api/v1/lists/', 
                        {list:
                          {
                            name: 'New list created via front end'
                          }
                        }
                      );
    } catch (error) {
      console.error("Error inserting list:", error);
    }
  };

  const handleActionEvent = () => {
    switch(`${props.actionEvent}`) {
      case 'delete':
        handleDelete();
        break;
      case 'insert':
        handleInsert();
        break;
      case 'new_list':
        handleNewList();
        break;
      default:
        console.log(`${props.actionEvent}`)
    }
  };

  return(
      <span className="grid grid-rows-subgrid grid-cols-subgrid gap-4 row-span-3">
        <button onClick={handleActionEvent} className={props.style} title={props.toolTip}>{props.label}</button>
      </span>
  );
}
export default Button