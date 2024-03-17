// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react';
import ReactDOM from 'react-dom';
import 'stylesheets/base.css';

import App from './components/App';
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const queryClient = new QueryClient();


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <QueryClientProvider client={queryClient}>

      <App />
    </QueryClientProvider>,
    document.body.appendChild(document.createElement('div')));
});
