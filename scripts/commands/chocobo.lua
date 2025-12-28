-----------------------------------
-- func: chocobo <color> <head> <tail> <feet>
-- desc: Register and use a chocobo with a specific look
--
-- examples:
-- Plain chocobo: !chocobo
-- Plain chocobo with enlarged tail: !chocobo yellow tail
-- Green chocobo with enlarged beak: !chocobo green head
-- Black chocobo with all look changes: !chocobo black head feet tail
-- etc.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ssss'
}

local chocobo = {}

chocobo.color =
{
    yellow = xi.chocobo.color.YELLOW,
    black  = xi.chocobo.color.BLACK,
    blue   = xi.chocobo.color.BLUE,
    red    = xi.chocobo.color.RED,
    green  = xi.chocobo.color.GREEN,
}

commandObj.onTrigger = function(player, arg, arg2, arg3, arg4)
    local color = chocobo.color[arg] or xi.chocobo.color.YELLOW
    local traits =
    {
        largeBeak   = false,
        fullTail    = false,
        largeTalons = false,
    }

    local traitArgs = { arg2, arg3, arg4 }

    for _, traitArg in ipairs(traitArgs) do
        if traitArg then
            if traitArg == 'head' then
                traits.largeBeak = true
            elseif traitArg == 'tail' then
                traits.fullTail = true
            elseif traitArg == 'feet' then
                traits.largeTalons = true
            end
        end
    end

    player:registerChocobo(color, traits)

    player:delStatusEffectSilent(xi.effect.MOUNTED)
    player:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, xi.mount.CHOCOBO, 0, 1800, 0, 64, true)
end

return commandObj
