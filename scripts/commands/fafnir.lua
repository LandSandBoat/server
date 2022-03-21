-----------------------------------
-- func: fafnir
-- desc: Summon a fightable Fafnir (no loot)
-- note:
-----------------------------------

cmdprops =
{
    permission = 5,
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()

    -- Fafnir's entry in mob_groups:
    -- INSERT INTO `mob_groups` VALUES (5,1280,154,'Fafnir',0,128,805,70000,0,90,90,0);
    --                       groupId ---^       ^--- groupZoneId

    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
        x = player:getXPos(),
        y = player:getYPos(),
        z = player:getZPos(),
        rotation = player:getRotPos(),
        groupId = 5,
        groupZoneId = 154,
    })

    mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())

    mob:setDropID(0) -- No loot!

    -- Dynamic mobs skip the regular bindings for onMobDeath, so if you want to
    -- add logic to their deaths, you need to use a listener:
    mob:addListener("DEATH", "DYNAMIC_FAFNIR_DEATH", function(mobArg)
        mobArg:removeListener("DYNAMIC_FAFNIR_DEATH")

        -- Do stuff here
    end)

    mob:spawn()

    player:PrintToPlayer(string.format("Spawning Fafnir (Lv: %i, HP: %i)\n%s", mob:getMainLvl(), mob:getMaxHP(), mob))
end
