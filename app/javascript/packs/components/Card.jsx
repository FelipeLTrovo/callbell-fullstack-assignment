import React from 'react';
import Button from './Button';
import InputText from './InputText.jsx'


function Card(props){
  return(
    <div className="rounded shadow-2xl h-48 m-4 hover:bg-gray-900">
      <InputText rowSize="1" maxChar="15" callerComponent="cardName" cardId={props.cardId} style="rounded-nonefont-bold text-gray-400 text-2xl mb-1 text-center bg-transparent col-start-1 resize-none overflow-hidden" text={props.name}/>
      <InputText rowSize="5" colSize="5" maxChar="155" callerComponent="cardDesc" cardId={props.cardId} style="text-gray-400 text-center bg-transparent col-start-1 resize-none overflow-hidden" text={props.description ? props.description : ''}/>
      <Button label="X" toolTip="Delete this card" style="text-gray-400 row-start-6 col-start-2 hover:bg-red-700 w-10 h-10 absolute justify-center" cardId={props.cardId} actionEvent="delete" />
    </div>
  );
}
export default Card