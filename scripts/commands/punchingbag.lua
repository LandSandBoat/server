-----------------------------------
-- func: fafnir
-- desc: Summon a fightable Fafnir (no loot)
-- note:
-----------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()

    local mob = zone:insertDynamicEntity({
        -- NPC or MOB
        objtype = xi.objType.MOB,
        name = "Training Dummy",

        -- Set the position using in-game x, y and z
        x = player:getXPos(),
        y = player:getYPos(),
        z = player:getZPos(),
        rotation = player:getRotPos(),

        look = "0x01000208C41022209F30C4409F504E61B4701980",
        groupId = 6,
        groupZoneId = 100,
        releaseIdOnDisappear = true,

        onMobSpawn = function(mob)
		    mob:hideHP(true)
			mob:setClaimable(false)
		    mob:setUnkillable(true)
            mob:addStatusEffect(xi.effect.TERROR, 0, 0, 3600)
        end,

        onMobFight = function(mob, target)
            if not mob:addStatusEffect(xi.effect.TERROR) then
                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 3600)
            end

            if mob:getHPP() < 100 then
                mob:setHP(20000)
            end
        end,
    })

    -- Use the mob object as you normally would
    mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())
    mob:setDropID(0) -- No loot!
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:addStatusEffect(xi.effect.TERROR, 0, 0, 3600)
    mob:spawn()
    player:PrintToPlayer(string.format("Spawning Fafnir (Lv: %i, HP: %i)\n%s", mob:getMainLvl(), mob:getMaxHP(), mob))
end
