-----------------------------------
-- BCNM Functions
-----------------------------------
require('scripts/globals/battlefield')
require('scripts/globals/missions')
-----------------------------------
xi = xi or {}
xi.bcnm = xi.bcnm or {}

local battlefields =
{
    [xi.zone.SEALIONS_DEN] =
    {
        { 0,  992,    0 },   -- One to Be Feared (PM6-4)
    },
}

-----------------------------------
-- Check requirements for registrant and allies
-----------------------------------
local function checkReqs(player, npc, bfid, registrant)
    local battlefield = xi.battlefield.contents[bfid]
    if battlefield then
        return battlefield:checkRequirements(player, npc, registrant)
    end

    local promathiaMission = player:getCurrentMission(xi.mission.log_id.COP)

    -- Requirements to register a battlefield
    local registerReqs =
    {
        [992] = function() -- PM6-4: One to be Feared
            return promathiaMission == xi.mission.id.cop.ONE_TO_BE_FEARED and
                player:getCharVar('Mission[6][638]Status') == 3
        end,
    }

    -- Determine whether player meets battlefield requirements
    local req = registrant and registerReqs[bfid]

    if not req or req() then
        return true
    else
        return false
    end
end
