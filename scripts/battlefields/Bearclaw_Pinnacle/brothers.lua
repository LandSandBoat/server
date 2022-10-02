-----------------------------------
-- Brothers
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !gotoid 16801894
-----------------------------------
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

local content = Battlefield:new({
    zoneId = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId = xi.battlefield.id.BROTHERS,
    maxPlayers = 18,
    levelCap = 75,
    timeLimit = utils.minutes(30),
    rules =
    {
        xi.battlefield.rules.ALLOW_SUBJOBS,
        xi.battlefield.rules.LOSE_EXP,
        xi.battlefield.rules.REMOVE_3MIN,
    },
    menuBit = 3,
    entryNpc = "Wind_Pillar_4",
    exitNpc = "Wind_Pillar_Exit",
    requiredKeyItems = { xi.ki.ZEPHYR_FAN },
    grantXP = 3500,
})

function content:onBattlefieldEnter(player, battlefield)
    if Battlefield.onBattlefieldEnter(self, player, battlefield) then
        player:messageSpecial(ID.text.ZEPHYR_RIPS, xi.ki.ZEPHYR_FAN)
    end
end

content.groups =
{
    {
        mobs = { "Eldertaur" },
        mods =
        {
            [xi.mod.DMGMAGIC] = -1000,
            [xi.mod.SLEEPRES] = 75,
        },
        mobMods =
        {
            [xi.mobMod.SIGHT_RANGE] = 30,
        },
    },
    {
        mobs = { "Mindertaur" },
        mods =
        {
            [xi.mod.DMGMAGIC] = -1000,
            [xi.mod.SILENCERES] = 75,
            [xi.mod.SLEEPRES] = 50,
        },
        mobMods =
        {
            [xi.mobMod.SIGHT_RANGE] = 30,
        }
    },
}

content:addEssentialMobs({ "Eldertaur", "Mindertaur" })

content.loot =
{
    {
        { itemid =    0, droprate = xi.battlefield.dropChance.VERY_LOW }, -- nothing
        { itemid = 1767, droprate = xi.battlefield.dropChance.NORMAL }, -- Eltoro Leather
        { itemid = 1762, droprate = xi.battlefield.dropChance.NORMAL }, -- Cassia Lumber
        { itemid = 1771, droprate = xi.battlefield.dropChance.NORMAL }, -- Dragon Bone
    },

    {
        { itemid =    0, droprate = xi.battlefield.dropChance.EXTREMELY_HIGH }, -- nothing
        { itemid = 1842, droprate = xi.battlefield.dropChance.LOW }, -- Cloud Evoker
    },

    {
        quantity = 2,
        { itemid =     0, droprate = xi.battlefield.dropChance.LOW }, -- nothing
        { itemid = 15302, droprate = xi.battlefield.dropChance.LOW }, -- Scouter's Rope
        { itemid = 17277, droprate = xi.battlefield.dropChance.LOW }, -- Hedgehog Bomb
        { itemid = 17707, droprate = xi.battlefield.dropChance.LOW }, -- Martial Anelace
        { itemid = 18098, droprate = xi.battlefield.dropChance.LOW }, -- Martial Lance
        { itemid =  4748, droprate = xi.battlefield.dropChance.HIGH }, -- Scroll of Raise III
    },
}

return content:register()
