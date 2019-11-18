// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

// let liveSocket = new LiveSocket("/live", Socket)
const session_uuid = document.getElementById("editor").dataset.sessionUuid
const liveSocket = new LiveSocket("/live", Socket, {params: {session_uuid: session_uuid}})
liveSocket.connect()

// If we're on the post show page
// Get the postID
const postId = "abcd"
let channel = liveSocket.channel("post:" + postId, {})
channel.join() 

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
