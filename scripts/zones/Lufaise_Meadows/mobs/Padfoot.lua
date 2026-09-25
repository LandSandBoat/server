-----------------------------------
-- Area: Lufaise Meadows
--   NM: Padfoot
-- !pos -43.689 0.487 -328.028 24
-- !pos 260.445 -1.761 -27.862 24
-- !pos 412.447 -0.057 -200.161 24
-- !pos -378.950 -15.742 144.215 24
-- !pos -141.523 -15.529 91.709 24
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)

    mob:addListener('ITEM_DROPS', 'ITEM_DROPS_PADFOOT', function(mobArg, loot)
        if mob:getID() == ID.mob.PADFOOT[GetServerVariable('realPadfoot')] then
            loot:addGroup(xi.drop_rate.GUARANTEED,
            {
                { item = xi.item.ASSAILANTS_RING, weight = 750 },
                { item = xi.item.ASTRAL_EARRING, weight = 250 },
            })
        else
            loot:addItem(xi.item.SHEEPSKIN, xi.drop_rate.VERY_COMMON)
            loot:addItem(xi.item.LANOLIN_CUBE, xi.drop_rate.GUARANTEED)
        end
    end)
end

entity.onMobDespawn = function(mob)
    local mobId = mob:getID()

    if mobId == ID.mob.PADFOOT[GetServerVariable('realPadfoot')] then
        local respawn = math.randomInt(75600, 86400) -- 21-24 hours

        for _, v in pairs(ID.mob.PADFOOT) do
            local padfootMob = GetMobByID(v)
            if padfootMob then
                if v ~= mobId and padfootMob:isSpawned() then
                    DespawnMob(v)
                end

                padfootMob:setRespawnTime(respawn)
            end
        end

        SetServerVariable('realPadfoot', math.randomInt(1, 5))
    end
end

return entity
