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


    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,

        name = "Fafnir",

        x = player:getXPos(),
        y = player:getYPos(),
        z = player:getZPos(),
        rotation = player:getRotPos(),

        -- Fafnir's entry in mob_groups:
        -- INSERT INTO `mob_groups` VALUES (5,1280,154,'Fafnir',0,128,805,70000,0,90,90,0);
        --                       groupId ---^       ^--- groupZoneId
        groupId = 5,
        groupZoneId = 154,

        onMobDeath = function(mob, player, isKiller)
            print("I AM DED")
        end,
    })

    mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())

    mob:setDropID(0) -- No loot!

    mob:spawn()

    player:PrintToPlayer(string.format("Spawning Fafnir (Lv: %i, HP: %i)\n%s", mob:getMainLvl(), mob:getMaxHP(), mob))
end
