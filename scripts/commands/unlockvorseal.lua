-----------------------------------
-- func: unlockvorseal
-- desc: Unlocks a vorseal
-- notes: WIP, will update once system is in place
-----------------------------------

require("scripts/globals/escha")
require("scripts/globals/vorseals")


cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!unlockvorseal {player} {vorseal}")
end

function onTrigger(player, vorseal)
    local targ
    local vorsealBit

    for k,v in pairs(xi.vorseals.upgradeMap) do
        if k == string.upper(vorseal) then
            print(xi.vorseals.upgradeMap[k])
        end
    end

    -- if (vorseal == nil) then
    --     error(player, "Invalid vorseal.")
    --     return
    -- end
end
