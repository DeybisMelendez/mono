local function rgb(r,g,b)
    return {r/255, g/255, b/255}
end

local green = rgb(160, 187, 6)
local darkgreen = rgb(48, 65, 11)

love.graphics.setBackgroundColor(green)
love.graphics.setColor(darkgreen)

local mono = {map = {1}, time = 0, fps = 0.0417, graphics = {}}
function mono:display()
    for y=1, #self.map do
        for x=1, #self.map[y] do
            if self.map[y][x] > 0 then
                love.graphics.rectangle("fill", x*10-9, y*10-9, 9, 9)
            end
        end
    end
end

function mono:draw(o,xo,yo)
    yo = yo or 0
    xo = xo or 0
    for y=1, #o do
        for x=1, #o[y] do
            if self.map[math.floor(y+yo)] ~= nil then
                if self.map[math.floor(y+yo)][math.floor(x+xo)] ~= nil then
                    self.map[math.floor(y+yo)][math.floor(x+xo)] = math.ceil(o[y][x])
                end
            end
        end
    end
end

function mono:clear()
    local map = {}
    for y=1, 64 do
        table.insert(map, {})
        for _=1, 96 do
            table.insert(map[y], 0)
        end
    end
    self.map = map
end
mono:clear()

function mono:rectangle(t,xo,yo,w,h)
    if t == "fill" then
        for y=1, h do
            for x=1, w do
                if self.map[math.floor(y+yo-1)] ~= nil then
                    if self.map[math.floor(y+yo-1)][math.floor(x+xo-1)] ~= nil then
                        self.map[y+yo-1][x+xo-1] = 1
                    end
                end
            end
        end
    elseif t == "line" then
        for y=yo, h+yo-1 do
            for x=xo, w+xo-1 do
                if x == xo or x == xo + w-1 or y == yo or y == yo + h-1 then
                    if self.map[math.floor(y)] ~= nil then
                        if self.map[math.floor(y)][math.floor(x)] ~= nil then
                            self.map[math.floor(y)][math.floor(x)] = 1
                        end
                    end
                end
            end
        end
    end
end

function love.draw()
    mono:display()
end

function love.update(dt)
    mono.time = mono.time + dt
    if mono.time >= mono.fps then
        mono.time = 0
        mono:clear()
        if mono.update then mono.update() end
    end
end
return mono
