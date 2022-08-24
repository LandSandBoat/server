-----------------------------------
-- Claim Shield
-----------------------------------
require("modules/module_utils")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------
local m = Module:new("claim_shield")

local claimshieldTime = 7500

-- NOTE: These names are as they are as filenames.
-- Example: Behemoth's Dominion => Behemoths_Dominion
-- Example: King Behemoth       => King_Behemoth
-- { zone name, mob name }
-- Format:
local nmsToShield =
{
    { "Attohwa_Chasm", "Citipati" },
    { "Attohwa_Chasm", "Tiamat" },
    { "Attohwa_Chasm", "Xolotl" },
    { "Caedarva_Mire", "Khimaira" },
    { "FeiYin", "Capricious_Cassie" },
    { "Garlaige_Citadel", "Serket" },
    { "Gustav_Tunnel", "Bune" },
    { "Jugner_Forest", "King_Arthro" },
    { "King_Ranperres_Tomb", "Vrtra" },
    { "Labyrinth_of_Onzozo", "Lord_of_Onzozo" },
    { "Mount_Zhayolm", "Cerberus" },
    { "Rolanberry_Fields", "Simurgh" },
    { "Sauromugue_Champaign", "Roc" },
    { "Sea_Serpent_Grotto", "Charybdis" },
    { "Wajaom_Woodlands", "Hydra" },
    { "Western_Altepa_Desert", "King_Vinegarroon" },
}

-- NOTE: At the time we iterate over these entries, the Lua zone and mob objects won't be ready,
--     : so we deal with everything as strings for now.
for _, entry in pairs(nmsToShield) do
    local zoneName = entry[1]
    local mobName = entry[2]

    m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobSpawn", zoneName, mobName),
    function(mob)
        print(string.format("Applying Claimshield to %s for %ims", mob:getName(), claimshieldTime))
        mob:setClaimable(false)
        mob:setUnkillable(true)
        mob:setCallForHelpBlocked(true)
        mob:stun(claimshieldTime)

        mob:timer(claimshieldTime, function(mobArg)
            local enmityList = mobArg:getEnmityList()
            local numEntries = #enmityList

            mobArg:setClaimable(true)
            mobArg:setUnkillable(false)
            mob:setCallForHelpBlocked(false)

            mobArg:resetAI()
            mobArg:setHP(mobArg:getMaxHP())

            local claimWinner = utils.randomEntry(enmityList)["entity"]
            if claimWinner then
                mobArg:updateClaim(claimWinner)
                print(string.format("Claimshield Winner: %s - %s, out of %i entries", mobArg:getName(), claimWinner:getName(), numEntries))
            end

            super(mobArg)
        end)
    end)
end

return m
