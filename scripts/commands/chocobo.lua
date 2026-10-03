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

local colors =
{
    yellow = xi.chocoboRaising.color.YELLOW,
    black  = xi.chocoboRaising.color.BLACK,
    blue   = xi.chocoboRaising.color.BLUE,
    red    = xi.chocoboRaising.color.RED,
    green  = xi.chocoboRaising.color.GREEN,
}

commandObj.onTrigger = function(player, arg, arg2, arg3, arg4)
    local chocobo =
    {
        color       = colors[arg] or xi.chocoboRaising.color.YELLOW,
        largeBeak   = false,
        fullTail    = false,
        largeTalons = false,
        speed       = xi.chocoboRaising.whistle.ridingSpeed(255, { xi.chocoboRaising.ability.GALLOP }, 1),
        minutes     = xi.chocoboRaising.whistle.ridingMinutes(xi.chocoboRaising.ridingTimeMaxRank),
    }

    local traitArgs = { arg2, arg3, arg4 }

    for _, traitArg in ipairs(traitArgs) do
        if traitArg then
            if traitArg == 'head' then
                chocobo.largeBeak = true
            elseif traitArg == 'tail' then
                chocobo.fullTail = true
            elseif traitArg == 'feet' then
                chocobo.largeTalons = true
            end
        end
    end

    player:registerChocobo(chocobo)

    player:delStatusEffectSilent(xi.effect.MOUNTED)
    player:addStatusEffect(xi.effect.MOUNTED,
    {
        power    = xi.mount.CHOCOBO,
        duration = chocobo.minutes * 60,
        origin   = player,
        subPower = xi.chocoboRaising.personalChocoboFlag,
        silent   = true,
    })
end

return commandObj
