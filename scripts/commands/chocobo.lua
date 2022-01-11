-----------------------------------
-- func: chocobo <varType> <varName>
-- desc: checks player or server variable and returns result value.
-----------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 0,
    parameters = "ssss"
}

local chocobo = {}

chocobo.color =
{
    yellow = 0x0000,
    black  = 0x0200,
    blue   = 0x0400,
    red    = 0x0600,
    green  = 0x0800,
}

chocobo.look =
{
    head = 0x0001, -- enlarged beak and crest (discernment)
    feet = 0x0008, -- bigger feet and talons  (strength)
    tail = 0x0040, -- extra tail feathers     (endurance)
}

function onTrigger(player, arg, arg2, arg3, arg4)
    local look = tonumber(arg) or chocobo.color[arg] or 0

    if chocobo.look[arg2] then
        look = look + chocobo.look[arg2]
    end
    if chocobo.look[arg3] then
        look = look + chocobo.look[arg3]
    end
    if chocobo.look[arg4] then
        look = look + chocobo.look[arg4]
    end

    player:registerChocobo(look)
    player:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, 1, 0, 1800, true)
end
