import * as React from "react";
import * as ReactDOM from "react-dom";
import Components from "./components";

document.querySelectorAll("[data-rendered=true]")
  .forEach(el => {
    const componentName = el.getAttribute("data-component");
    const props = JSON.parse(el.getAttribute("data-props"))
    const component = Components[componentName];
    const element = React.createElement(component, props);
    ReactDOM.hydrate(element, el)
  });
