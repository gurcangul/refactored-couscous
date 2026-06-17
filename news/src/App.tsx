import React from 'react'
import { Routes, Route } from 'react-router-dom'

function App() {
  return (
    <Routes>
      <Route path="/" element={<div><h1>News UI</h1></div>} />
    </Routes>
  )
}

export default App
