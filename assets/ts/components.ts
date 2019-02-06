import HelloWorld from "./HelloWorld";

interface Components {
  [name: string]: React.ComponentClass
}

const Components: Components = {
  "HelloWorld": HelloWorld
};

export default Components;
