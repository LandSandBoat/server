-----------------------------------
-- Area: Apollyon SW
--  Mob: Jidra
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")

function onMobDeath(mob, player, isKiller)
    if isKiller then
        local mobID = mob:getID()
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()

        if mobID == ID.mob.APOLLYON_SW_MOB[2] then
            local battlefield = player:getBattlefield()
            local players = battlefield:getPlayers()
            for i, member in pairs(players) do
                member:messageSpecial(ID.text.GATE_OPEN)
                member:messageSpecial(ID.text.TIME_LEFT, battlefield:getRemainingTime()/60)
            end
            GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[2]):setAnimation(8)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[2]+1 then
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+8):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+8):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_SW_MOB[2]+8):updateEnmity(player)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[2]+2 then
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+9):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+9):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_SW_MOB[2]+9):updateEnmity(player)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[2]+3 then
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+10):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+10):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_SW_MOB[2]+10):updateEnmity(player)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[2]+4 then
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+11):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+11):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_SW_MOB[2]+11):updateEnmity(player)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[2]+5 then
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+12):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+12):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_SW_MOB[2]+12):updateEnmity(player)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[2]+6 then
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+13):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+13):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_SW_MOB[2]+13):updateEnmity(player)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[2]+7 then
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+14):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_SW_MOB[2]+14):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_SW_MOB[2]+14):updateEnmity(player)
        end
    end
end
