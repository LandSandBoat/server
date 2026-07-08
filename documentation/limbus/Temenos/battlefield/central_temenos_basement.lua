-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 1st Floor
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_BASEMENT,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(15),
    index            = 7,
    area             = 8,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.item.METAL_CHIP },
    name             = 'CENTRAL_TEMENOS_BASEMENT',
    lootCrateId      = ID.npc.CB_LOOT_CRATE,
    timeExtension    = 5,
})

content.groups =
{
    {
        mobs    = { 'Temenos_Aern' },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        mixins =
        {
            require('scripts/mixins/families/aern'),
            require('scripts/mixins/job_special'),
        },

        setup = function(battlefield, mobs)
            local remainingAern = #mobs

            for _, mob in ipairs(mobs) do
                mob:setLocalVar('ALLOW_DROPS', 1)
                mob:setLocalVar('AERN_RERAISE_MAX', 5)
                mob:removeListener('DESPAWN_AERN_TIME')

                -- When the last Aern despawns then spawn the Temenos Ghrah
                mob:addListener('DESPAWN', 'DESPAWN_AERN_GHRAH', function(mobArg)
                    remainingAern = remainingAern - 1

                    if remainingAern <= 0 then
                        local boss = mob:getZone():queryEntitiesByName('Temenos_Ghrah')[1]
                        boss:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        boss:spawn()
                    end
                end)

                mob:addListener('ITEM_DROPS', 'ITEM_DROPS_AERN', function(mobArg, loot)
                    local quantity = math.min(3, mob:getLocalVar('AERN_RERAISES'))

                    loot:addItem(xi.item.ANCIENT_BEASTCOIN, xi.drop_rate.GUARANTEED, quantity)
                end)
            end

            -- Aern are split into groups and 6 of the 10 random groups are assigned a time extension to a random mob
            local groups =
            {
                {  1,  2 },
                {  3,  4 },
                {  5,  6 },
                {  7,  8 },
                {  9, 10 },
                { 11, 12 },
                { 13, 14, 15 },
                { 16, 17, 18 },
                { 19, 20, 21, 22 },
                { 23, 24, 25, 26, 27 },
            }

            groups = utils.shuffle(groups)

            for i = 1, 6, 1 do
                local group = groups[i]
                local mob   = mobs[group[math.random(1, #group)]]

                -- Award time extension once the aern fully despawns and is no longer reraising
                mob:addListener('DESPAWN', 'DESPAWN_AERN_TIME', function(mobArg)
                    local mobBattlefield = mob:getBattlefield()

                    if mobBattlefield then
                        content:extendTimeLimit(ID, mobBattlefield)
                    end
                end)
            end
        end,
    },

    {
        spawned = false,
        mobs    = { 'Aerns_Avatar' },
        mixins  = { require('scripts/mixins/families/avatar') },
    },

    {
        spawned = false,
        mobs =
        {
            'Aerns_Wynav',
            'Aerns_Euvhi',
            'Aerns_Elemental',
        },
    },

    {
        mobs    = { 'Temenos_Ghrah' },
        spawned = false,
        death   = function(battlefield, mob, count)
            npcUtil.showCrate(GetNPCByID(ID.npc.CB_LOOT_CRATE))
        end,
    }
}

content.loot =
{
    [ID.npc.CB_LOOT_CRATE] =
    {
        {
            quantity = 7,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = 1000 },
        },

        {
            { item = xi.item.NONE,       weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.METAL_CHIP, weight = xi.loot.weight.NORMAL    },
        },
    }
}

return content:register()
