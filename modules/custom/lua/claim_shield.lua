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
}

-- Find the position of a target entity in a table,
-- only if they have matching ids
local tableFindPosByID = function(t, target)
    for index, entity in ipairs(t) do
        if entity:getID() == target:getID() then
            return index
        end
    end
    return nil
end

-- Using entity ids: dedupe a table in-place
local dedupeByID = function(t)
    local seen = {}
    for index, entity in ipairs(t) do
        if seen[entity:getID()] then
            table.remove(t, index)
        else
            seen[entity:getID()] = true
        end
    end
end

-- Called when the claimshield period ends
local timerFunc = function(mob)
    local enmityList = mob:getEnmityList()

    -- Filter so that pets will only count as a single entry along
    -- with their masters
    local entries = {}
    for _, v in pairs(enmityList) do
        local entity = v["entity"]
        local master = entity:getMaster()
        if
            not entity:isPC() and
            master and
            master:isPC()
        then
            table.insert(entries, master)
        else
            table.insert(entries, entity)
        end
    end

    -- Remove duplicates from entries table caused by pets or other shenanigans
    dedupeByID(entries)

    local numEntries = #entries

    mob:setClaimable(true)
    mob:setUnkillable(false)
    mob:setCallForHelpBlocked(false)

    mob:resetAI()
    mob:setHP(mob:getMaxHP())
    mob:delStatusEffectsByFlag(0xFFFF) -- Delete all effects with all flags

    -- Select a winner
    local claimWinner = utils.randomEntry(entries)
    if claimWinner then
        mob:updateClaim(claimWinner)

        -- Message winner and their party/alliance that they've won
        local alliance = claimWinner:getAlliance()
        for _, member in pairs(alliance) do
            local str = string.format("Your group has won the lottery for %s! (out of %i players)", mob:getPacketName(), numEntries)
            if #alliance == 1 then
                str = string.format("You have won the lottery for %s! (out of %i players)", mob:getPacketName(), numEntries)
            end
            member:PrintToPlayer(str, xi.msg.channel.SYSTEM_3, "")

            -- Remove from entries table
            local pos = tableFindPosByID(entries, member)
            if pos then
                table.remove(entries, pos)
            end
        end

        -- Everyone left in the entries table isn't part of the winning group, message them and
        -- clear them from the enmity list
        for _, member in pairs(entries) do
            local str = string.format("Your group was not successful in the lottery for %s. (out of %i players)", mob:getPacketName(), numEntries)
            if #alliance == 1 then
                str = string.format("Your were not successful in the lottery for %s. (out of %i players)", mob:getPacketName(), numEntries)
            end
            member:PrintToPlayer(str, xi.msg.channel.SYSTEM_3, "")
            mob:clearEnmityForEntity(member)
        end
    end
end

-- Called on entity onMobSpawn, sets up timerFunc
local listenerFunc = function(mob)
    print(string.format("Applying Claimshield to %s for %ims", mob:getPacketName(), claimshieldTime))

    mob:setClaimable(false)
    mob:setUnkillable(true)
    mob:setCallForHelpBlocked(true)
    mob:stun(claimshieldTime)

    mob:timer(claimshieldTime, timerFunc)
end

-- Main entrypoint of each override
local overrideFunc = function(mob)
    mob:addListener("SPAWN", mob:getPacketName() .. "_CS_SPAWN", listenerFunc)

    -- Call original onMobInitialize
    super(mob)
end

-- NOTE: At the time we iterate over these entries, the Lua zone and mob objects won't be ready,
--     : so we deal with everything as strings for now.
for _, entry in pairs(nmsToShield) do
    m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobInitialize", entry[1], entry[2]), overrideFunc)
end

return m
