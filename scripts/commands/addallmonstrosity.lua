-----------------------------------
-- func: addallmonstrosity
-- desc: Adds all species, instincts, and variants for monstrosity
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!addallmonstrosity (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    local data =
    {
        levels =
        {
            [xi.monstrosity.species.RABBIT]     = 1,
            [xi.monstrosity.species.MANDRAGORA] = 1,
            [xi.monstrosity.species.LIZARD]     = 1,
        },
        instincts =
        {
            [00] = 0xFF,
            [01] = 0xFF,
            [02] = 0xFF,
            [03] = 0xFF,
            [04] = 0xFF,
            [05] = 0xFF,
            [06] = 0xFF,
            [07] = 0xFF,
            [08] = 0xFF,
            [09] = 0xFF,
            [10] = 0xFF,
            [11] = 0xFF,
            [12] = 0xFF,

            [20] = 0xFF, -- Unlock all first tier player race instincts
        },
        variants =
        {
            [00] = 0xFF,
            [01] = 0xFF,
        }
    }

    targ:setMonstrosity(data)

    player:PrintToPlayer(string.format('%s now has all monstrosity data.', targ:getName()))
end

return commandObj
