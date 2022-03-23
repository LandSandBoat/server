-----------------------------------
-- func: fafnir
-- desc: Summon a fightable Fafnir (no loot)
-- note:
-----------------------------------

cmdprops =
{
<<<<<<< HEAD
    permission = 3,
=======
    permission = 5,
>>>>>>> 0b0d3a5b8eb5a8996dafc01a9c6ae8856964d490
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()

<<<<<<< HEAD
    -- Fafnir's entry in mob_groups:
    -- INSERT INTO `mob_groups` VALUES (5,1280,154,'Fafnir',0,128,805,70000,0,90,90,0);
    --                       groupId ---^       ^--- groupZoneId

    local mob = zone:insertDynamicEntity({
        objtype = xi.objType.MOB,
=======
    local mob = zone:insertDynamicEntity({
        -- NPC or MOB
        objtype = xi.objType.MOB,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Fafnir",

        -- Set the position using in-game x, y and z
>>>>>>> 0b0d3a5b8eb5a8996dafc01a9c6ae8856964d490
        x = player:getXPos(),
        y = player:getYPos(),
        z = player:getZPos(),
        rotation = player:getRotPos(),
<<<<<<< HEAD
        groupId = 5,
        groupZoneId = 154,
    })

=======

        -- Fafnir's entry in mob_groups:
        -- INSERT INTO `mob_groups` VALUES (5,1280,154,'Fafnir',0,128,805,70000,0,90,90,0);
        --                       groupId ---^       ^--- groupZoneId
        groupId = 5,
        groupZoneId = 154,

        -- You can provide an onMobDeath function if you want: if you don't
        -- add one, an empty one will be inserted for you behind the scenes.
        onMobDeath = function(mob, playerArg, isKiller)
            -- Do stuff
        end,
    })

    -- Use the mob object as you normally would
>>>>>>> 0b0d3a5b8eb5a8996dafc01a9c6ae8856964d490
    mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())

    mob:setDropID(0) -- No loot!

<<<<<<< HEAD
    -- Dynamic mobs skip the regular bindings for onMobDeath, so if you want to
    -- add logic to their deaths, you need to use a listener:
    mob:addListener("DEATH", "DYNAMIC_FAFNIR_DEATH", function(mobArg)
        mobArg:removeListener("DYNAMIC_FAFNIR_DEATH")

        -- Do stuff here
    end)

=======
>>>>>>> 0b0d3a5b8eb5a8996dafc01a9c6ae8856964d490
    mob:spawn()

    player:PrintToPlayer(string.format("Spawning Fafnir (Lv: %i, HP: %i)\n%s", mob:getMainLvl(), mob:getMaxHP(), mob))
end
