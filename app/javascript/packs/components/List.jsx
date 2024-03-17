import React from 'react';
import Card from './Card.jsx'
import Button from './Button.jsx'
import InputText from './InputText.jsx'


function List(props){
  return(
    <div className="rounded shadow p-4 col-span-12 md:col-span-6 lg:col-span-3 h-auto bg-gray-800" >
        <InputText colSize="1" rowSize="1" maxChar="25" callerComponent="listName" listId={`${props.list.id}`} style="rounded shadow font-bold text-gray-300 text-2xl mb-1 text-center bg-transparent hover:bg-gray-900 resize-none overflow-hidden" text={props.list.name}/>
      {props.cards.map((card) => (
        <Card cardId={card.id} name={card.name} description={card.description} />
        ))}
        <Button label="+" toolTip="Add a new card to this list" style="text-gray-400 row-start-1 col-start-2 hover:bg-green-700 w-10 h-10" listId={props.list.trello_id} actionEvent="insert" />
    </div>
  );
}
export default List