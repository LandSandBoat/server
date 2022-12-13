-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 4th Floor
-- !additem silver_chip
-- !additem cerulean_chip
-- !additem orchid_chip
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
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_4TH_FLOOR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(60),
    index            = 3,
    area             = 4,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.items.SILVER_CHIP, xi.items.CERULEAN_CHIP, xi.items.ORCHID_CHIP },
    name             = "CENTRAL_TEMENOS_4TH_FLOOR",
})

local despawnGroupCrates = function(crateGroup)
    for i = 1, crateGroup.count do
        local crate = GetEntityByID(crateGroup.offset + i - 1)
        if crate:getLocalVar("opened") == 0 then
            crate:setLocalVar("opened", 1)
            npcUtil.disappearCrate(crate)
        end
    end
end

function content:onBattlefieldInitialise(battlefield)
    Limbus.onBattlefieldInitialise(self, battlefield)

    -- Crates are always spawned with in fixed groups
    -- Randomize crate type order by shuffling setup functions
    for index, group in ipairs(ID.CENTRAL_TEMENOS_4TH_FLOOR.npc.GROUPS) do
        local itemIndex = math.random(1, group.count)
        for j = 1, group.count do
            local crateID = group.offset + j - 1
            local crate = GetEntityByID(crateID)
            crate:setStatus(xi.status.NORMAL)
            crate:setUntargetable(false)
            crate:setAnimationSub(8)
            crate:setModelId(961)

            crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", function(player, npc)
                npcUtil.openCrate(npc, function()
                    despawnGroupCrates(group)

                    if j == itemIndex then
                        content:handleLootRolls(player:getBattlefield(), content.loot[1], npc)
                    else
                        -- Spawn a random mob from the corresponding mob group
                        local mobGroup = ID.CENTRAL_TEMENOS_4TH_FLOOR.mob.GROUPS[index]
                        local mobID = mobGroup.offset + math.random(0, mobGroup.count - 1)
                        local mob = GetMobByID(mobID)
                        mob:setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos(), npc:getRotPos())
                        mob:spawn()
                        mob:updateEnmity(player)
                    end
                end)
            end)
        end
    end
end

content.groups =
{
    {
        mobs = { "Armoury_Crate_Fourth" },
        setup = function(battlefield, crates)
            for _, crate in ipairs(crates) do
                crate:setBattleID(1) -- Different battle ID prevents the crate from being hit by AOEs
            end
        end
    },

    {
        mobs =
        {
            "Kingslayer_Doggvdegg",
            "JiGho_Ageless",
            "Koo_Buzu_the_Theomanic",
            "Yagudos_Elemental",
            "Yagudos_Avatar",
            "Mystic_Avatar_Ifrit",
            "Mystic_Avatar_Shiva",
            "Mystic_Avatar_Garuda",
            "Mystic_Avatar_Titan",
            "Mystic_Avatar_Ramuh",
            "Mystic_Avatar_Leviathan",
            "Enhanced_Koenigstiger",
            "Enhanced_Pygmaioi",
            "Enhanced_Kettenkaefer",
            "Enhanced_Salamander",
            "Enhanced_Jelly",
            "Enhanced_Makara",
            "Enhanced_Akbaba",
        },

        spawned = false,
    },

    {
        mobs =
        {
            "Kingslayer_Doggvdegg",
            "JiGho_Ageless",
            "Koo_Buzu_the_Theomanic",
        },

        spawned = false,
        mixins = { require("scripts/mixins/job_special") }
    },

    {
        mobs = { "Proto-Ultima" },
        setup = function(battlefield, mobs)
            local ultima = mobs[1]
            -- Despawn all crates when Proto-Ultima is engaged
            ultima:addListener("ENGAGE", "ULTIMA_ENGAGED", function(mob, target)
                for _, group in ipairs(ID.CENTRAL_TEMENOS_4TH_FLOOR.npc.GROUPS) do
                    despawnGroupCrates(group)
                end
            end)
        end,

        allDeath = function(battlefield, mob)
            local pos = mob:getSpawnPos()
            mob:setPos(pos.x, pos.y, pos.z, 64)
            xi.limbus.spawnFrom(mob, ID.CENTRAL_TEMENOS_4TH_FLOOR.npc.LOOT_CRATE)
        end
    },
}

content.loot =
{
    [1] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1934, weight = 200 },
            { item =  1930, weight = 200 },
            { item =  1958, weight = 200 },
            { item =  2658, weight = 400 },
            { item =  1940, weight = 200 },
        },
    },

    [ID.CENTRAL_TEMENOS_4TH_FLOOR.npc.LOOT_CRATE] =
    {
        {
            quantity = 7,
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1920, weight = 659 },
            { item =  1924, weight = 394 },
            { item =  1923, weight = 388 },
            { item =  1922, weight = 404 },
        },

        {
            { item =  1924, weight = 394 },
            { item =  1922, weight = 402 },
            { item =  1920, weight = 659 },
            { item =  1923, weight = 383 },
        },

        {
            { item =  1921, weight = 265 },
            { item =     0, weight = 735 },
        },
    },
}

return content:register()
