import React, { useState, useEffect } from 'react';
import axios from "axios";

function InputText(props){
  const [value, setValue] = useState(props.text);

  useEffect(() => {
    setValue(props.text)
}, [props.text]);

  const handleListName = async (newName) => {
   try {
      await axios.put(`http://localhost:3000/api/v1/lists/${props.listId}`, 
                        {list:
                          {
                            name: newName,
                            id: props.listId
                          }
                        }
                      );
    } catch (error) {
      console.error("Error updating list:", error);
    }
  };

  const handleCardName = async (newName) => {
    try {
       await axios.patch(`http://localhost:3000/api/v1/cards/${props.cardId}`, 
                         {card:
                           {
                             name: newName,
                             id: props.cardId
                           }
                         }
                       );
     } catch (error) {
       console.error("Error updating card name:", error);
     }
   };

   const handleCardDesc = async (newDesc) => {
    try {
       await axios.patch(`http://localhost:3000/api/v1/cards/${props.cardId}`, 
                         {card:
                           {
                             desc: newDesc,
                             id: props.cardId
                           }
                         }
                       );
     } catch (error) {
       console.error("Error updating card description:", error);
     }
   };

  const handleKeyDown = (event) => {
    if (event.key === "Enter") {
      event.preventDefault();
      handleCallerComponent(event.target.value);
    }
  };

  const handleChange = (event) => {
    setValue(event.target.value);
  };

  const handleCallerComponent = async (newText) => {
    switch(`${props.callerComponent}`) {
      case 'cardName':
        handleCardName(newText);
        break;
      case 'cardDesc':
        handleCardDesc(newText);
        break;
      case 'listName':
        handleListName(newText);
        break;
      default:
        console.log(`${props.callerComponent}`)
    }
  };

  return(
    <div className="grid grid-rows-subgrid grid-cols-subgrid gap-4 row-span-3">
      <textarea id="textArea" wrap="none" maxLength={props.maxChar} rows={props.rowSize} cols={props.colSize} onKeyDown={handleKeyDown} className={props.style} value={value} onChange={handleChange}/>
    </div>
  );
}
export default InputText