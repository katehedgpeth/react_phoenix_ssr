import * as ReactServer from "react-dom/server";
import * as React from "react";
import * as readline from "readline";
import Components from "./components";

require("@babel/polyfill");
require("@babel/register")({
  presets: ["@babel/preset-env"]
});

interface makeHtmlProps {
  name: string;
  props: any;
}

interface makeHtmlError {
  type?: string;
  message: string;
  stacktrace?: Array<string>;
}

interface makeHtmlResponse {
  error: makeHtmlError | null;
  markup: string | null;
  component: string;
}

function makeHtml({ name, props }: makeHtmlProps): makeHtmlResponse {
  const component = Components[name];
  if (!component) {
    return {
      component: name,
      markup: null,
      error: {
        message: `unknown component`
      }
    }
  }
  try {
    const element = Components[name];
    const createdElement = React.createElement(element, props)

    const markup = ReactServer.renderToString(createdElement)

    return {
      error: null,
      markup: markup,
      component: name,
    }
  } catch (err) {
    return {
      markup: null,
      component: name,
      error: {
        type: err.constructor.name,
        message: err.message,
        stacktrace: err.stack,
      },
    };
  }
}

function startServer() {
  process.stdin.on('end', () => {
    process.exit()
  })

  const readLineInterface = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false,
  })

  readLineInterface.on('line', line => {
    const input = JSON.parse(line);
    const result = makeHtml(input);
    const jsonResult = JSON.stringify(result);
    process.stdout.write(jsonResult);
  })
}

module.exports = { startServer }

if (require.main === module) {
  startServer()
}
