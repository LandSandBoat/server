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
        xi.battlefield.rules.SPAWN_TREASURE_ON_WIN,
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
            [xi.mobMod.DRAW_IN] = 1,
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
    },
    {
        mobs = { "Eldertaur", "Mindertaur" },
        superlink = true,
        allDeath = utils.bind(content.handleAllMonstersDefeated, content)
    },
}

content.loot =
{
    {
        { itemid =    0, droprate =  59 }, -- nothing
        { itemid = 1767, droprate = 271 }, -- Eltoro Leather
        { itemid = 1762, droprate = 340 }, -- Cassia Lumber
        { itemid = 1771, droprate = 330 }, -- Dragon Bone
    },

    {
        { itemid =    0, droprate = 956 }, -- nothing
        { itemid = 1842, droprate =  44 }, -- Cloud Evoker
    },

    {
        { itemid =     0, droprate = 118 }, -- nothing
        { itemid = 15302, droprate = 123 }, -- Scouter's Rope
        { itemid = 17277, droprate = 163 }, -- Hedgehog Bomb
        { itemid = 17707, droprate = 167 }, -- Martial Anelace
        { itemid = 18098, droprate = 148 }, -- Martial Lance
        { itemid =  4748, droprate = 281 }, -- Scroll of Raise III
    },

    {
        { itemid =     0, droprate = 118 }, -- nothing
        { itemid = 15302, droprate = 128 }, -- Scouter's Rope
        { itemid = 17277, droprate = 163 }, -- Hedgehog Bomb
        { itemid = 17707, droprate = 167 }, -- Martial Anelace
        { itemid = 18098, droprate = 153 }, -- Martial Lance
        { itemid =  4748, droprate = 271 }, -- Scroll of Raise III
    },
}

return content:register()
