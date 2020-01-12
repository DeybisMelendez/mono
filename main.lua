local mono = require "mono"
local function v(x, y)
    return {x = x, y = y}
end
local snake = {v(3,12),v(4,12), v(5,12)}

function mono.update()
    mono:square("line", 3, 3, 92, 60)
     for _, val in ipairs(snake) do
         mono:square("fill", val.x*4, val.y*4, 4, 4)
     end
end
