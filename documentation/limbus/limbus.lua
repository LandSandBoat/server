-----------------------------------
-- Global file for Apollyopn and Temenos
-----------------------------------
require('scripts/globals/battlefield')
require('scripts/globals/interaction/container')
-----------------------------------
xi = xi or {}
xi.limbus = xi.limbus or {}

function xi.limbus.enter(player, entrance)
    switch (entrance): caseof
    {
        [0] = function()
            player:setPos(-668, 0.1, -666, 209, 38)  --  instance entrer -599 0 -600
        end, --  sortiezone -642, -4, -642, -637, 4, -637

        [1] = function()
            player:setPos(643, 0.1, -600, 124, 38)  --  instance entrer 600 1 -600
        end, --  sortiezone  637, -4, -642, 642, 4, -637
    }
end

function xi.limbus.showRecoverCrate(crateID)
    local crate = GetMobByID(crateID)

    if crate then
        crate:setAnimationSub(8)
        crate:setStatus(xi.status.NORMAL)
        crate:setUntargetable(false)
        crate:resetLocalVars()
    end
end

function xi.limbus.hideCrate(crate)
    crate:setStatus(xi.status.DISAPPEAR)
    crate:setUntargetable(true)
    crate:resetLocalVars()
end

function xi.limbus.spawnFrom(mob, crateID)
    local crate = GetEntityByID(crateID)

    if crate and crate:getLocalVar('opened') == 0 then
        crate:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
        crate:setStatus(xi.status.NORMAL)
        crate:setUntargetable(false)
        crate:setAnimationSub(8)
    end
end

function xi.limbus.spawnRecoverFrom(mob, crateID)
    local crate = GetMobByID(crateID)

    if crate then
        crate:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
        xi.limbus.showRecoverCrate(crateID)
    end
end

Limbus         = setmetatable({ }, { __index = Battlefield })
Limbus.__index = Limbus

---@diagnostic disable-next-line: duplicate-set-field
Limbus.__eq    = function(m1, m2)
    return m1.name == m2.name
end

Limbus.name = ''
Limbus.serverVar = ''

-- Creates a new Limbus Battlefield interaction
-- Data takes the additional following keys:
--  - name: The name of the Limbus area.
--  - exitLocation: Where to boot the player out. This is specifically used for Apollyon areas.
--  - timeExtension: How much time to grant when openning a time Armoury Crate.
---@diagnostic disable-next-line: duplicate-set-field
function Limbus:new(data)
    data.createsWornItem = false
    data.showTimer       = false
    local obj            = Battlefield:new(data)

    setmetatable(obj, self)
    obj.name          = data.name
    obj.ID            = zones[obj.zoneId][obj.name]
    obj.serverVar     = '[' .. obj.name .. ']Time'
    obj.exitLocation  = data.exitLocation or 0
    obj.timeExtension = data.timeExtension or 0

    return obj
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:register()
    Battlefield.register(self)

    -- Add recover crates that are technically "mobs"
    if self.ID and self.ID.npc then
        table.insert(self.groups, { mobIds = self.ID.npc.RECOVER_CRATES })
    end

    return self
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:onEventFinishEnter(player, csid, option, npc)
    Battlefield.onEventFinishEnter(self, player, csid, option)

    local battlefield    = player:getBattlefield()
    local initiatorId, _ = battlefield:getInitiator()

    if player:getID() == initiatorId then
        local ID       = zones[player:getZoneID()]
        local alliance = player:getAlliance()

        for _, member in pairs(alliance) do
            if member:getZoneID() == player:getZoneID() then
                member:messageSpecial(ID.text.HUM)
            end
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:onBattlefieldInitialize(battlefield)
    Battlefield.onBattlefieldInitialize(self, battlefield)
    SetServerVariable(self.serverVar, battlefield:getTimeLimit() / 60)
    self:closeDoors()

    local ID = zones[battlefield:getZoneID()][self.name]

    -- Setup Item Crates
    if ID.npc.ITEM_CRATES then
        for i, crateID in ipairs(ID.npc.ITEM_CRATES) do
            local crate = GetEntityByID(crateID)

            if crate then
                xi.limbus.hideCrate(crate)
                crate:addListener('ON_TRIGGER', 'TRIGGER_ITEM_CRATE', utils.bind(self.handleOpenItemCrate, self))
            end
        end
    end

    -- Setup Time Crates
    if ID.npc.TIME_CRATES then
        for i, crateID in ipairs(ID.npc.TIME_CRATES) do
            local crate = GetEntityByID(crateID)

            if crate then
                xi.limbus.hideCrate(crate)
                crate:addListener('ON_TRIGGER', 'TRIGGER_TIME_CRATE', utils.bind(self.handleOpenTimeCrate, self))
            end
        end
    end

    -- Setup Recover Crates
    -- Recover crates are special in that they are mobs that perform a skill on the player when triggered
    if ID.npc.RECOVER_CRATES then
        for i, crateID in ipairs(ID.npc.RECOVER_CRATES) do
            local crate = GetEntityByID(crateID)

            if crate then
                xi.limbus.hideCrate(crate)
                crate:setBattleID(1) -- Different battle ID prevents the crate from being hit by AOEs
                crate:addListener('ON_TRIGGER', 'TRIGGER_RECOVER_CRATE', utils.bind(self.handleOpenRecoverCrate, self))
            end
        end
    end

    -- Setup Winning Loot Crate
    if self.lootCrateId then
        local crate = GetEntityByID(self.lootCrateId)

        if crate then
            xi.limbus.hideCrate(crate)
            crate:addListener('ON_TRIGGER', 'TRIGGER_LOOT_CRATE', utils.bind(self.handleOpenLootCrate, self))
        end
    end

    -- Setup Linked Crates (can only open one)
    if ID.LINKED_CRATES then
        for crateID, _ in pairs(ID.LINKED_CRATES) do
            local mainCrate = GetEntityByID(crateID)

            if mainCrate then
                mainCrate:addListener('ON_TRIGGER', 'TRIGGER_LINKED_CRATE', utils.bind(self.handleLinkedCrate, self))
            end
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    if battlefield:getRemainingTime() % 60 == 0 then
        SetServerVariable(self.serverVar, battlefield:getRemainingTime() / 60)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:onBattlefieldRegister(player, battlefield)
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:onBattlefieldEnter(player, battlefield)
    Battlefield.onBattlefieldEnter(self, player, battlefield)
    player:setCharVar('Cosmo_Cleanse_TIME', os.time())
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:onBattlefieldDestroy(battlefield)
    SetServerVariable(self.serverVar, 0)
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:onBattlefieldWin(player, battlefield)
    player:startEvent(32001, { [0] = self.exitLocation, [4] = self.zoneId, [5] = battlefield:getArea() - 1 })
end

---@diagnostic disable-next-line: duplicate-set-field
function Limbus:onBattlefieldLeave(player, battlefield, leavecode)
    Battlefield.onBattlefieldLeave(self, player, battlefield, leavecode)

    local ID = zones[battlefield:getZoneID()]
    player:messageSpecial(ID.text.HUM + 1)
end

function Limbus:extendTimeLimit(ID, battlefield)
    -- Set battlefield time limit.
    local timeLimit = battlefield:getTimeLimit()
    battlefield:setTimeLimit(timeLimit + utils.minutes(self.timeExtension))

    -- Push messages to all battlefield players.
    local remaining = battlefield:getRemainingTime() / 60

    for _, player in pairs(battlefield:getPlayers()) do
        player:messageSpecial(ID.text.TIME_EXTENDED, self.timeExtension)
        player:messageSpecial(ID.text.TIME_LEFT, remaining)
    end
end

function Limbus:handleOpenItemCrate(player, crate)
    npcUtil.openCrate(crate, function()
        self:handleLootRolls(player:getBattlefield(), self.loot[crate:getID()], crate)
    end)
end

function Limbus:handleOpenTimeCrate(player, crate)
    npcUtil.openCrate(crate, function()
        self:extendTimeLimit(zones[self.zoneId], player:getBattlefield())
    end)
end

function Limbus:handleOpenRecoverCrate(player, crate)
    npcUtil.openCrate(crate, function()
        -- Use wz_recover_all to heal players
        crate:useMobAbility(1531, player)
    end)
end

function Limbus:handleOpenLootCrate(player, crate)
    npcUtil.openCrate(crate, function()
        local battlefield = player:getBattlefield()

        self:handleLootRolls(battlefield, self.loot[self.lootCrateId], crate)
        battlefield:setLocalVar('cutsceneTimer', self.delayToExit)
        battlefield:setStatus(xi.battlefield.status.WON)
    end)
end

function Limbus:handleLinkedCrate(player, npc)
    for _, crateID in ipairs(self.ID.LINKED_CRATES[npc:getID()]) do
        local crate = GetEntityByID(crateID)

        if crate then
            crate:setLocalVar('opened', 1)
            npcUtil.disappearCrate(crate)
        end
    end
end

function Limbus:openDoor(battlefield, floor)
    local door = GetNPCByID(self.ID.npc.PORTAL[floor])

    if not door or door:getAnimation() == xi.animation.OPEN_DOOR then
        return
    end

    local ID        = zones[door:getZoneID()]
    local remaining = battlefield:getRemainingTime() / 60

    for i, player in pairs(battlefield:getPlayers()) do
        player:messageSpecial(ID.text.GATE_OPEN)
        player:messageSpecial(ID.text.TIME_LEFT, remaining)
    end

    door:setAnimation(xi.animation.OPEN_DOOR)
end

function Limbus:closeDoors()
    if self.ID.npc.PORTAL then
        for _, doorID in ipairs(self.ID.npc.PORTAL) do
            GetNPCByID(doorID):setAnimation(xi.animation.CLOSE_DOOR)
        end
    end
end
