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
    { "Castle_Oztroja", "Mee_Deggi_the_Punisher" },
    { "Castle_Oztroja", "Quu_Domi_the_Gallant" },
    { "FeiYin", "Capricious_Cassie" },
    { "FeiYin", "Eastern_Shadow" },
    { "FeiYin", "Northern_Shadow" },
    { "FeiYin", "Southern_Shadow" },
    { "FeiYin", "Western_Shadow" },
    { "Garlaige_Citadel", "Serket" },
    { "Giddeus", "Hoo_Mjuu_the_Torrent" },
    { "Gustav_Tunnel", "Bune" },
    { "Jugner_Forest", "King_Arthro" },
    { "King_Ranperres_Tomb", "Vrtra" },
    { "Labyrinth_of_Onzozo", "Lord_of_Onzozo" },
    { "Lufaise_Meadows", "Padfoot" },
    { "Maze_of_Shakhrami", "Argus" },
    { "Maze_of_Shakhrami", "Leech_King" },
    { "Mount_Zhayolm", "Cerberus" },
    { "Rolanberry_Fields", "Eldritch_Edge" },
    { "Rolanberry_Fields", "Simurgh" },
    { "Rolanberry_Fields_[S]", "Lamina" },
    { "Sauromugue_Champaign", "Blighting_Brand" },
    { "Sauromugue_Champaign", "Roc" },
    { "Sauromugue_Champaign_[S]", "Hyakinthos" },
    { "Sea_Serpent_Grotto", "Charybdis" },
    { "South_Gustaberg", "Leaping_Lizzy" },
    { "Uleguerand_Range", "Jormungand" },
    { "Valkurm_Dunes", "Valkurm_Emperor" },
    { "Wajaom_Woodlands", "Hydra" },
    { "Western_Altepa_Desert", "King_Vinegarroon" },
    { "South_Gustaberg", "Leaping_Lizzy" },
    { "Valkurm_Dunes", "Valkurm_Emperor" },
    { "Maze_of_Shakhrami", "Argus" },
    { "Sea_Serpent_Grotto", "Charybdis" },
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
        mob:stun(claimshieldTime)

        mob:timer(claimshieldTime, function(mobArg)
            local enmityList = mobArg:getEnmityList()
            local numEntries = #enmityList

            mobArg:setClaimable(true)
            mobArg:setUnkillable(false)

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
