import React from "react";
import axios from "axios";
import Navbar from './Navbar.jsx'
import List from './List.jsx'
import { useQueries } from "@tanstack/react-query";


export default function App() {

  const [listsQuery, cardsQuery] = useQueries({
    queries: [
      {
        queryKey: ['lists'],
        queryFn: () => 
          axios
            .get('http://localhost:3000/api/v1/lists')
            .then((res) => res.data), refetchInterval: 1000,
      },

      {
        queryKey: ['cards'],
        queryFn: () =>
          axios
            .get('http://localhost:3000/api/v1/cards')
            .then((res) => res.data), refetchInterval: 1000
      },
    ],
    
  });

  if (listsQuery.isLoading) return 'Loading Lists...';
  if (cardsQuery.isLoading) return 'Loading Cards...';

  if (listsQuery.error)
    return 'An error has occurred: ' + listsQuery.error.message;

  if (cardsQuery.error)
    return 'An error has occurred: ' + cardsQuery.error.message;
  
  
  return (
    <>
      <Navbar />
      <div className="grid grid-cols-12 gap-4 bg-gray-900 p-4 min-h-screen min-w-screen">
         {listsQuery.data.map((list) => (
           <List list={list} cards={cardsQuery.data.filter((card) => card.list_id === list.id)} />
          ))}
      </div>
    </>
  );
}
