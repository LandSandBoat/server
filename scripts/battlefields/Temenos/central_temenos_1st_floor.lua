-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 1st Floor
-- !additem emerald_chip
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_1ST_FLOOR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(45),
    index            = 6,
    area             = 7,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.items.EMERALD_CHIP },
    name             = "CENTRAL_TEMENOS_1ST_FLOOR",
})

function content:handleMobPartnerDeath(mobs, battlefield, mob, count)
    if count > 1 then
        return
    end

    local zone = mob:getZone()
    local target = zone:queryEntitiesByName(mobs[1])[1]
    if target and mob:getID() == target:getID() then
        target = zone:queryEntitiesByName(mobs[2])[1]
    end

    target:timer(15000, function(mobArg)
        if target:isAlive() then
            target:injectActionPacket(target:getID(), 11, 439, 0, 24, 0, 307, 0)
            target:addMod(xi.mod.REGAIN, 150)
        end
    end)
end

content.groups =
{
    {
        mobs = { "Airi", "Temenos_Cleaner" },
        death = utils.bind(content.handleMobPartnerDeath, content, { "Airi", "Temenos_Cleaner" }),
    },

    {
        mobs = { "Iruci", "Temenos_Weapon" },
        death = utils.bind(content.handleMobPartnerDeath, content, { "Iruci", "Temenos_Weapon" }),
    },

    {
        mobs = { "Enhanced_Dragon", "Enhanced_Ahriman" },
        death = utils.bind(content.handleMobPartnerDeath, content, { "Enhanced_Dragon", "Enhanced_Ahriman" }),
    },

    {
        mobs =
        {
            "Airi",
            "Temenos_Cleaner",
            "Iruci",
            "Temenos_Weapon",
            "Enhanced_Dragon",
            "Enhanced_Ahriman",
        },

        mods = { [xi.mod.REGEN] = 24 },
        allDeath = function(battlefield, mob)
            xi.limbus.spawnFrom(mob, ID.CENTRAL_TEMENOS_1ST_FLOOR.npc.LOOT_CRATE)
        end
    }
}

content.loot =
{
    [ID.CENTRAL_TEMENOS_1ST_FLOOR.npc.LOOT_CRATE] =
    {
        {
            quantity = 7,
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1930, weight = 265 },
            { item =  1938, weight = 118 },
            { item =  1948, weight = 147 },
            { item =  1958, weight = 147 },
            { item =  1952, weight = 118 },
            { item =  2656, weight = 235 },
        },

        {
            { item =  1986, weight = 1000 },
        },
    }
}

return content:register()
