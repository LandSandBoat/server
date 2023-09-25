-----------------------------------
-- func: chocobo <colour> <head> <tail> <feet>
-- desc: Register and use a chocobo with a specific look
--
-- examples:
-- Plain chocobo: !chocobo
-- Plain chocobo with enlarged tail: !chocobo yellow tail
-- Green chocobo with enlarged beak: !chocobo green head
-- Black chocobo with all look changes: !chocobo black head feet tail
-- etc.
-----------------------------------
cmdprops =
{
    permission = 1,
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

    player:delStatusEffectSilent(xi.effect.MOUNTED)
    player:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, xi.mount.CHOCOBO, 0, 1800, 0, 64, true)
end
