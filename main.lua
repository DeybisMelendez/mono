local mono = require "mono"
local function v(x, y)
    return {x = x, y = y}
end
local bird = {pos = v(30, 10), size = 8, mov = 0}
local wall = {pos = v(96, -50), size = v(6, 50)}
local finish = false

local function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)

  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function mono.update()
    mono:rectangle("line", bird.pos.x, bird.pos.y, bird.size, bird.size)
    mono:rectangle("fill", wall.pos.x, wall.pos.y, wall.size.x, wall.size.y)
    mono:rectangle("fill", wall.pos.x, wall.pos.y+70, wall.size.x, wall.size.y)
    if not finish then
        bird.mov = bird.mov + 0.2
        if bird.mov > 2 then
            bird.mov = 2
        end
        bird.pos.y = bird.pos.y + bird.mov
        wall.pos.x = wall.pos.x - 1
        if wall.pos.x  < -wall.size.x then
            wall.pos.x = 96
            wall.pos.y = math.random(44) - 50
        end
        if CheckCollision(bird.pos.x, bird.pos.y, bird.size, bird.size,
                wall.pos.x, wall.pos.y, wall.size.x, wall.size.y) or
                CheckCollision(bird.pos.x, bird.pos.y, bird.size, bird.size,
                wall.pos.x, wall.pos.y+70, wall.size.x, wall.size.y) or
                bird.pos.y <1 or bird.pos.y + bird.size > 64 then
            finish = true
        end
    end
end
function love.keypressed(key)
    if key == "a" then
        bird.mov = -2
        if finish then
            finish = false
            wall.pos = v(96, -50)
            wall.size = v(6, 50)
            bird.pos = v(30, 10)
            bird.mov = 0
        end
    end
end
