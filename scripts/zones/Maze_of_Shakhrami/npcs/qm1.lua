-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: ???
-- Spawns Aroma Crawler - RSE Sachets
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: Retail accurate spawn points.
local aromaCrawlerSpawnPoints =
{
    {  188.893, -0.568,  102.911 },
    {  113.680, -0.660,  -97.914 },
    { -150.508, -9.176,  139.733 },
}

local rseSachets =
{
    [xi.race.HUME_M  ] = xi.item.BALM_SACHET,
    [xi.race.HUME_F  ] = xi.item.MILLEFLEURS_SACHET,
    [xi.race.ELVAAN_M] = xi.item.OLIBANUM_SACHET,
    [xi.race.ELVAAN_F] = xi.item.ATTAR_SACHET,
    [xi.race.TARU_M  ] = xi.item.SWEET_SACHET,
    [xi.race.TARU_F  ] = xi.item.SWEET_SACHET,
    [xi.race.MITHRA  ] = xi.item.CIVET_SACHET,
    [xi.race.GALKA   ] = xi.item.MUSK_SACHET,
}

entity.onTrigger = function(player, npc)
    local playerRace = player:getRace()
    local sachet     = rseSachets[playerRace]

    if not sachet then
        return
    end

    if
        VanadielRSELocation() == 2 and
        VanadielRSERace() == playerRace and
        not player:hasItem(sachet) and
        -- ??? set to hidden and respawns 10-30 minutes after NM is defeated.
        npcUtil.popFromQM(player, npc, ID.mob.AROMA_CRAWLER, { claim = true, hide = math.randomInt(600, 1800), look = true, radius = 1 })
    then
        GetMobByID(ID.mob.AROMA_CRAWLER):addListener('ITEM_DROPS', 'ITEM_DROPS_RSE', function(mob, loot)
            loot:addItem(sachet, xi.drop_rate.UNCOMMON)
        end)

        -- Move the ??? to a new spawn point for the next pop
        npcUtil.queueMove(npc, aromaCrawlerSpawnPoints[math.randomInt(1, 3)])
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
