local bg = {{}}
table.insert(bg[1], 0)
for _=1, 92 do
    table.insert(bg[1], 1)
end
local l = {1}
for _=1, 92 do
    table.insert(l, 0)
end
table.insert(l, 1)
for _=1, 60 do
    table.insert(bg, l)
end
table.insert(bg, {})
for _=1, 92 do
    table.insert(bg[60], 1)
end
return bg
