---@meta

-- luacheck: ignore 241
---@class CBaseEntity
local CBaseEntity = {}

---@param mob CBaseEntity
---@param messageID integer
---@param p0 integer?
---@param p1 integer?
---@param p2 integer?
---@param p3 integer?
---@return nil
function CBaseEntity:showText(mob, messageID, p0, p1, p2, p3)
end

---@param PLuaBaseEntity CBaseEntity
---@param messageID integer
---@param arg2 boolean
---@param arg3 integer?
---@return nil
---@overload fun(PLuaBaseEntity: CBaseEntity, messageID: integer, arg2: integer, arg3: integer?): nil
---@overload fun(PLuaBaseEntity: CBaseEntity, messageID: integer, arg2: table, arg3: integer?): nil
function CBaseEntity:messageText(PLuaBaseEntity, messageID, arg2, arg3)
end

---@param message string
---@param messageTypeObj integer?
---@param nameObj string?
---@return nil
function CBaseEntity:printToPlayer(message, messageTypeObj, nameObj)
end

---@param message string Message to send
---@param arg1 integer? Message Type
---@param arg2 integer? Message Range
---@param arg3 string Name
---@return nil
function CBaseEntity:printToArea(message, arg1, arg2, arg3)
end

---@param messageID integer
---@param p0 integer?
---@param p1 integer?
---@param target CBaseEntity?
---@return nil
function CBaseEntity:messageBasic(messageID, p0, p1, target)
end

---@param messageID integer
---@param entity CBaseEntity?
---@param p0 integer?
---@param p1 integer?
---@param p2 integer?
---@param p3 integer?
---@param chat integer?
---@return nil
function CBaseEntity:messageName(messageID, entity, p0, p1, p2, p3, chat)
end

---@param messageID integer
---@param PEntity CBaseEntity
---@param arg2 integer?
---@param arg3 integer?
---@return nil
function CBaseEntity:messagePublic(messageID, PEntity, arg2, arg3)
end

---@param messageID integer
---@param param0 integer?
---@param param1 integer?
---@param param2 integer?
---@param param3 integer?
---@param showName boolean?
---@return nil
function CBaseEntity:messageSpecial(messageID, param0, param1, param2, param3, showName)
end

---@param messageID integer
---@param p0 integer?
---@param p1 integer?
---@return nil
function CBaseEntity:messageSystem(messageID, p0, p1)
end

---@param speaker CBaseEntity?
---@param p0 integer
---@param p1 integer
---@param message integer
---@return nil
function CBaseEntity:messageCombat(speaker, p0, p1, message)
end

---@param messageID integer
---@return nil
function CBaseEntity:messageStandard(messageID)
end

---@param obj table
---@return nil
function CBaseEntity:customMenu(obj)
end

---@nodiscard
---@param varName string
---@return integer
function CBaseEntity:getCharVar(varName)
end

---@param varName string
---@param value integer
---@param expiry integer?
---@return nil
function CBaseEntity:setCharVar(varName, value, expiry)
end

---@param varName string
---@param expiry integer
---@return nil
function CBaseEntity:setCharVarExpiration(varName, expiry)
end

---@param varname string
---@param value integer
---@return nil
function CBaseEntity:incrementCharVar(varname, value)
end

---@param varName string
---@param value integer
---@param expiry integer?
---@return nil
function CBaseEntity:setVolatileCharVar(varName, value, expiry)
end

---@nodiscard
---@return table
function CBaseEntity:getLocalVars()
end

---@nodiscard
---@param var string
---@return integer
function CBaseEntity:getLocalVar(var)
end

---@param var string
---@param val integer
---@return nil
function CBaseEntity:setLocalVar(var, val)
end

---@return nil
function CBaseEntity:resetLocalVars()
end

---@param prefix string
---@return nil
function CBaseEntity:clearVarsWithPrefix(prefix)
end

---@nodiscard
---@return integer
function CBaseEntity:getLastOnline()
end

---@param filename string
---@return nil
function CBaseEntity:injectPacket(filename)
end

---@param inTargetID integer
---@param inCategory integer
---@param inAnimationID integer
---@param inSpecEffect integer
---@param inReaction integer
---@param inMessage integer
---@param inActionParam integer
---@param inParam integer
---@return nil
function CBaseEntity:injectActionPacket(inTargetID, inCategory, inAnimationID, inSpecEffect, inReaction, inMessage, inActionParam, inParam)
end

---@param command string
---@param entity CBaseEntity?
---@return nil
function CBaseEntity:entityVisualPacket(command, entity)
end

---@param command string
---@param target CBaseEntity?
---@return nil
function CBaseEntity:entityAnimationPacket(command, target)
end

---@param packetData table
---@return nil
function CBaseEntity:sendDebugPacket(packetData)
end

---@param EventID integer
---@param paramTable table
---@return nil
---@overload fun(EventID: integer, p0: integer?, p1: integer?, p2: integer?, p3: integer?, p4: integer?, p5: integer?, p6: integer?, p7: integer?, textTable: integer?): nil
function CBaseEntity:startEvent(EventID, paramTable)
end

---@param EventID integer
---@param string1 string
---@param string2 string
---@param string3 string
---@param string4 string
---@param op1 integer?
---@param op2 integer?
---@param op3 integer?
---@param op4 integer?
---@param op5 integer?
---@param op6 integer?
---@param op7 integer?
---@param op8 integer?
---@return nil
function CBaseEntity:startEventString(EventID, string1, string2, string3, string4, op1, op2, op3, op4, op5, op6, op7, op8)
end

---@param EventID integer
---@param paramTable table
---@return nil
---@overload fun(EventID: integer, p0: integer?, p1: integer?, p2: integer?, p3: integer?, p4: integer?, p5: integer?, p6: integer?, p7: integer?, textTable: integer?): nil
function CBaseEntity:startCutscene(EventID, paramTable)
end

---@param EventID integer
---@param paramTable table
---@return nil
---@overload fun(EventID: integer, p0: integer?, p1: integer?, p2: integer?, p3: integer?, p4: integer?, p5: integer?, p6: integer?, p7: integer?, textTable: integer?): nil
function CBaseEntity:startOptionalCutscene(EventID, paramTable)
end

---@param ... integer?
---@return nil
function CBaseEntity:updateEvent(...)
end

---@param string1 string?
---@param string2 string?
---@param string3 string?
---@param string4 string?
---@param op1 integer?
---@param op2 integer?
---@param op3 integer?
---@param op4 integer?
---@param op5 integer?
---@param op6 integer?
---@param op7 integer?
---@param op8 integer?
---@return nil
function CBaseEntity:updateEventString(string1, string2, string3, string4, op1, op2, op3, op4, op5, op6, op7, op8)
end

---@nodiscard
---@return CBaseEntity?
function CBaseEntity:getEventTarget()
end

---@nodiscard
---@return boolean
function CBaseEntity:isInEvent()
end

---@return nil
function CBaseEntity:release()
end

---@return boolean
function CBaseEntity:startSequence()
end

---@nodiscard
---@return boolean
function CBaseEntity:didGetMessage()
end

---@return nil
function CBaseEntity:resetGotMessage()
end

---@deprecated
function CBaseEntity:setFlag(flags)
end

---@nodiscard
---@return integer
function CBaseEntity:getMoghouseFlag()
end

---@param flag integer
---@return nil
function CBaseEntity:setMoghouseFlag(flag)
end

---@param arg0 boolean? If set, changes loc.zoning to the value provided.
---@return boolean
function CBaseEntity:needToZone(arg0)
end

---@nodiscard
---@return integer
function CBaseEntity:getID()
end

---@nodiscard
---@return integer
function CBaseEntity:getTargID()
end

---@nodiscard
---@return CBaseEntity?
function CBaseEntity:getCursorTarget()
end

---@nodiscard
---@return integer
function CBaseEntity:getObjType()
end

---@nodiscard
---@return boolean
function CBaseEntity:isPC()
end

---@nodiscard
---@return boolean
function CBaseEntity:isNPC()
end

---@nodiscard
---@return boolean
function CBaseEntity:isMob()
end

---@nodiscard
---@return boolean
function CBaseEntity:isPet()
end

---@nodiscard
---@return boolean
function CBaseEntity:isTrust()
end

---@nodiscard
---@return boolean
function CBaseEntity:isAlly()
end

---@return nil
function CBaseEntity:initNpcAi()
end

---@return nil
function CBaseEntity:resetAI()
end

---@nodiscard
---@return integer
function CBaseEntity:getStatus()
end

---@param status integer
---@return nil
function CBaseEntity:setStatus(status)
end

---@nodiscard
---@return integer
function CBaseEntity:getCurrentAction()
end

---@nodiscard
---@return boolean
function CBaseEntity:canUseAbilities()
end

---@param arg0 number
---@param arg1 number
---@param arg2 number
---@return nil
---@overload fun(arg0: table): nil
function CBaseEntity:lookAt(arg0, arg1, arg2)
end

---@param PLuaBaseEntity CBaseEntity
---@param nonGlobal boolean?
---@return nil
function CBaseEntity:facePlayer(PLuaBaseEntity, nonGlobal)
end

---@return nil
function CBaseEntity:clearTargID()
end

---@nodiscard
---@param arg0 number
---@param arg1 number
---@param arg2 number
---@return boolean
---@overload fun(arg0: table): boolean
function CBaseEntity:atPoint(arg0, arg1, arg2)
end

---@param x number
---@param y number
---@param z number
---@param flags integer?
function CBaseEntity:pathTo(x, y, z, flags)
end

---@param pointsTable table
---@param flagsObj integer?
---@return boolean
function CBaseEntity:pathThrough(pointsTable, flagsObj)
end

---@nodiscard
---@return boolean
function CBaseEntity:isFollowingPath()
end

---@param pauseObj boolean?
---@return nil
function CBaseEntity:clearPath(pauseObj)
end

---@return nil
function CBaseEntity:continuePath()
end

---@nodiscard
---@param arg0 number
---@param arg1 number
---@param arg2 number
---@return number
---@overload fun(arg0: table): number
function CBaseEntity:checkDistance(arg0, arg1, arg2)
end

---@param milliseconds integer?
---@return nil
function CBaseEntity:wait(milliseconds)
end

---@param target CBaseEntity
---@param followType integer
---@return nil
function CBaseEntity:follow(target, followType)
end

---@return nil
function CBaseEntity:unfollow()
end

---@deprecated
function CBaseEntity:WarpTo()
end

---@deprecated
function CBaseEntity:RoamAround()
end

---@deprecated
function CBaseEntity:LimitDistance()
end

---@param careful boolean
---@return nil
function CBaseEntity:setCarefulPathing(careful)
end

---@param seconds integer?
---@return nil
function CBaseEntity:openDoor(seconds)
end

---@param seconds integer?
---@return nil
function CBaseEntity:closeDoor(seconds)
end

---@param id integer
---@param lowerDoor integer
---@param upperDoor integer
---@param elevatorId integer
---@param reversed boolean
---@return nil
function CBaseEntity:setElevator(id, lowerDoor, upperDoor, elevatorId, reversed)
end

---@param id integer
---@param period integer
---@param minOffset integer
---@return nil
function CBaseEntity:addPeriodicTrigger(id, period, minOffset)
end

---@param seconds integer?
---@return nil
function CBaseEntity:showNPC(seconds)
end

---@param seconds integer?
---@return nil
function CBaseEntity:hideNPC(seconds)
end

---@param seconds integer?
---@return nil
function CBaseEntity:updateNPCHideTime(seconds)
end

---@nodiscard
---@param ignoreScholar boolean?
---@return integer
function CBaseEntity:getWeather(ignoreScholar)
end

---@param weatherType integer
---@return nil
function CBaseEntity:setWeather(weatherType)
end

---@param blockID integer
---@param musicTrackID integer
---@return nil
function CBaseEntity:changeMusic(blockID, musicTrackID)
end

---@param menu integer
---@return nil
function CBaseEntity:sendMenu(menu)
end

---@nodiscard
---@param guildID integer
---@param open integer
---@param close integer
---@param holiday integer
---@return boolean
function CBaseEntity:sendGuild(guildID, open, close, holiday)
end

---@return nil
function CBaseEntity:openSendBox()
end

---@return nil
function CBaseEntity:leaveGame()
end

---@param target CBaseEntity
---@param emID integer
---@param emMode integer
---@return nil
function CBaseEntity:sendEmote(target, emID, emMode)
end

---@nodiscard
---@param target CBaseEntity
---@param degrees integer?
---@return integer
---@overload fun(posX: number?, posY: number?, posZ: number?): integer
function CBaseEntity:getWorldAngle(target, degrees)
end

---@nodiscard
---@param target CBaseEntity
---@return integer
function CBaseEntity:getFacingAngle(target)
end

---@nodiscard
---@param target CBaseEntity
---@param angleArg integer?
---@return boolean
function CBaseEntity:isFacing(target, angleArg)
end

---@nodiscard
---@param target CBaseEntity
---@param angleArg integer?
---@return boolean
function CBaseEntity:isInfront(target, angleArg)
end

---@nodiscard
---@param target CBaseEntity
---@param angleArg integer?
---@return boolean
function CBaseEntity:isBehind(target, angleArg)
end

---@nodiscard
---@param target CBaseEntity
---@param angleArg integer?
---@return boolean
function CBaseEntity:isBeside(target, angleArg)
end

---@nodiscard
---@param arg0 boolean? Parameter will return player's destination zone if they are in the process of zoning (for use in onZoneIn)
---@return CZone?
function CBaseEntity:getZone(arg0)
end

---@nodiscard
---@return integer
function CBaseEntity:getZoneID()
end

---@nodiscard
---@return string
function CBaseEntity:getZoneName()
end

---@nodiscard
---@param zone integer
---@return boolean
function CBaseEntity:hasVisitedZone(zone)
end

---@nodiscard
---@return integer
function CBaseEntity:getPreviousZone()
end

---@nodiscard
---@return integer
function CBaseEntity:getCurrentRegion()
end

---@nodiscard
---@return integer
function CBaseEntity:getContinentID()
end

---@nodiscard
---@return boolean
function CBaseEntity:isInMogHouse()
end

---@nodiscard
---@return integer
function CBaseEntity:getPlayerTriggerAreaInZone()
end

---@param statusID integer
---@param animation integer
---@param matchTime boolean?
---@return nil
function CBaseEntity:updateToEntireZone(statusID, animation, matchTime)
end

---@param entityToUpdate CBaseEntity
---@param entityUpdate integer
---@param updateMask integer
---@return nil
function CBaseEntity:sendEntityUpdateToPlayer(entityToUpdate, entityUpdate, updateMask)
end

---@param entityToUpdate CBaseEntity
---@return nil
function CBaseEntity:sendEmptyEntityUpdateToPlayer(entityToUpdate)
end

---@return nil
function CBaseEntity:forceRezone()
end

---@return nil
function CBaseEntity:forceLogout()
end

---@nodiscard
---@return table
function CBaseEntity:getPos()
end

---@return nil
function CBaseEntity:showPosition()
end

---@nodiscard
---@return integer
function CBaseEntity:getXPos()
end

---@nodiscard
---@return integer
function CBaseEntity:getYPos()
end

---@nodiscard
---@return integer
function CBaseEntity:getZPos()
end

---@nodiscard
---@return integer
function CBaseEntity:getRotPos()
end

---@param rotation integer
---@return nil
function CBaseEntity:setRotation(rotation)
end

---@param x number?
---@param y number?
---@param z number?
---@param rot number?
---@return nil
---@overload fun(arg0: table): nil
function CBaseEntity:setPos(x, y, z, rot)
end

---@return nil
function CBaseEntity:warp()
end

---@param pos table
---@param arg1 integer|CBaseEntity?
---@return nil
function CBaseEntity:teleport(pos, arg1)
end

---@param teleType integer
---@param bitval integer
---@param setval integer?
---@return nil
function CBaseEntity:addTeleport(teleType, bitval, setval)
end

---@nodiscard
---@param type integer
---@param abysseaRegionObj integer?
---@return integer
function CBaseEntity:getTeleport(type, abysseaRegionObj)
end

---@nodiscard
---@param type integer
---@return table
function CBaseEntity:getTeleportTable(type)
end

---@nodiscard
---@param tType integer
---@param bit integer
---@param arg2 integer?
function CBaseEntity:hasTeleport(tType, bit, arg2)
end

---@param type integer
---@param teleportObj table|boolean
---@return nil
function CBaseEntity:setTeleportMenu(type, teleportObj)
end

---@nodiscard
---@param type integer
---@return table
function CBaseEntity:getTeleportMenu(type)
end

---@return nil
function CBaseEntity:setHomePoint()
end

---@param charName string
---@return nil
function CBaseEntity:resetPlayer(charName)
end

---@param targetID integer
---@param option boolean?
---@return nil
function CBaseEntity:goToEntity(targetID, option)
end

---@param playerName string
---@return boolean
function CBaseEntity:gotoPlayer(playerName)
end

---@param playerName string
---@return boolean
function CBaseEntity:bringPlayer(playerName)
end

---@nodiscard
---@param slot integer
---@return integer
function CBaseEntity:getEquipID(slot)
end

---@nodiscard
---@param slot integer
---@return CItem?
function CBaseEntity:getEquippedItem(slot)
end

---@nodiscard
---@param itemID integer
---@param location integer?
---@return boolean
function CBaseEntity:hasItem(itemID, location)
end

---@nodiscard
---@param itemID integer
---@return integer
function CBaseEntity:getItemCount(itemID)
end

-- TODO: This one is going to be really messy, might be better to create multiple definitions
-- for readability.
function CBaseEntity:addItem(...)
end

---@param itemID integer
---@param quantity integer
---@param containerID integer?
---@return boolean
function CBaseEntity:delItem(itemID, quantity, containerID)
end

---@param containerID integer?
---@return boolean
function CBaseEntity:delContainerItems(containerID)
end

---@param itemID integer
---@return boolean
function CBaseEntity:addUsedItem(itemID)
end

---@param itemID integer
---@param arg1 integer?
---@return boolean
function CBaseEntity:addTempItem(itemID, arg1)
end

---@nodiscard
---@param itemID integer
---@return integer
function CBaseEntity:getWornUses(itemID)
end

---@nodiscard
---@param itemID integer
---@return integer
function CBaseEntity:incrementItemWear(itemID)
end

---@nodiscard
---@param itemID integer
---@param location integer?
---@return CItem?
function CBaseEntity:findItem(itemID, location)
end


---@param size integer
---@param arg1 integer?
---@return nil
function CBaseEntity:createShop(size, arg1)
end

---@param itemID integer
---@param rawPrice number
---@param arg2 integer
---@param arg3 integer
---@return nil
---@overload fun(itemID: integer, rawPrice: number): nil
function CBaseEntity:addShopItem(itemID, rawPrice, arg2, arg3)
end

---@nodiscard
---@param guildID integer
---@return table
function CBaseEntity:getCurrentGPItem(guildID)
end

---@param lsname string
---@return boolean
function CBaseEntity:breakLinkshell(lsname)
end

---@param lsname string
---@param equip boolean
---@return boolean
function CBaseEntity:addLinkpearl(lsname, equip)
end

---@nodiscard
---@param name string
---@param mobFamily integer
---@param zeni integer
---@param skillIndex integer
---@param fp integer
---@return CItem?
function CBaseEntity:addSoulPlate(name, mobFamily, zeni, skillIndex, fp)
end

---@nodiscard
---@param locationID integer
---@return integer
function CBaseEntity:getContainerSize(locationID)
end

---@param locationID integer
---@param newSize integer
---@return nil
function CBaseEntity:changeContainerSize(locationID, newSize)
end

---@nodiscard
---@param locID integer?
---@return integer
function CBaseEntity:getFreeSlotsCount(locID)
end

---@return nil
function CBaseEntity:confirmTrade()
end

---@return nil
function CBaseEntity:tradeComplete()
end

---@return CTradeContainer?
function CBaseEntity:getTrade()
end

---@nodiscard
---@param itemID integer
---@param chkLevel boolean?
---@return boolean
function CBaseEntity:canEquipItem(itemID, chkLevel)
end

---@param itemID integer
---@param container integer?
---@return nil
function CBaseEntity:equipItem(itemID, container)
end

---@param itemID integer
---@return nil
function CBaseEntity:unequipItem(itemID)
end

---@param equipBlock integer
---@return nil
function CBaseEntity:setEquipBlock(equipBlock)
end

---@param slot integer
---@return nil
function CBaseEntity:lockEquipSlot(slot)
end

---@param slot integer
---@return nil
function CBaseEntity:unlockEquipSlot(slot)
end

---@nodiscard
---@param slot integer
---@return boolean
function CBaseEntity:hasSlotEquipped(slot)
end

---@nodiscard
---@return integer
function CBaseEntity:getShieldSize()
end

---@nodiscard
---@return integer
function CBaseEntity:getShieldDefense()
end

---@param setId integer
---@param modId integer
---@param modValue integer
---@return nil
function CBaseEntity:addGearSetMod(setId, modId, modValue)
end

---@return nil
function CBaseEntity:clearGearSetMods()
end

---@nodiscard
---@param container integer
---@param slotID integer
---@param equipID integer
---@return CItem?
function CBaseEntity:getStorageItem(container, slotID, equipID)
end

---@nodiscard
---@param slipId integer
---@param extraTable table
---@param storableItemIdsTable table
---@return integer
function CBaseEntity:storeWithPorterMoogle(slipId, extraTable, storableItemIdsTable)
end

---@nodiscard
---@param slipId integer
---@return table
function CBaseEntity:getRetrievableItemsForSlip(slipId)
end

---@param slipId integer
---@param itemId integer
---@param extraId integer
---@param extraData integer
---@return nil
function CBaseEntity:retrieveItemFromSlip(slipId, itemId, extraId, extraData)
end

---@nodiscard
---@return integer
function CBaseEntity:getRace()
end

---@nodiscard
---@return integer
function CBaseEntity:getGender()
end

---@nodiscard
---@return string
function CBaseEntity:getName()
end

---@nodiscard
---@return string
function CBaseEntity:getPacketName()
end

---@param newName string
---@param arg2 boolean?
---@return nil
function CBaseEntity:renameEntity(newName, arg2)
end

---@param isHidden boolean
---@return nil
function CBaseEntity:hideName(isHidden)
end

---@nodiscard
---@return integer
function CBaseEntity:getModelId()
end

---@param modelId integer
---@param slotObj integer?
---@return nil
function CBaseEntity:setModelId(modelId, slotObj)
end

---@nodiscard
---@return integer
function CBaseEntity:getCostume()
end

---@param costume integer
---@return nil
function CBaseEntity:setCostume(costume)
end

---@nodiscard
---@return integer
function CBaseEntity:getCostume2()
end

---@param costume integer
---@return nil
function CBaseEntity:setCostume2(costume)
end

---@nodiscard
---@return integer
function CBaseEntity:getAnimation()
end

---@param animation integer
---@return nil
function CBaseEntity:setAnimation(animation)
end

---@nodiscard
---@return integer
function CBaseEntity:getAnimationSub()
end

---@param animationsub integer
---@return nil
function CBaseEntity:setAnimationSub(animationsub)
end

---@nodiscard
---@return boolean
function CBaseEntity:getCallForHelpFlag()
end

---@param cfh boolean
---@return nil
function CBaseEntity:setCallForHelpFlag(cfh)
end

---@nodiscard
---@return boolean
function CBaseEntity:getCallForHelpBlocked()
end

---@param blocked boolean
---@return nil
function CBaseEntity:setCallForHelpBlocked(blocked)
end

---@nodiscard
---@return integer
function CBaseEntity:getNation()
end

---@param nation integer
---@return nil
function CBaseEntity:setNation(nation)
end

---@nodiscard
---@return integer
function CBaseEntity:getAllegiance()
end

---@param allegiance integer
---@return nil
function CBaseEntity:setAllegiance(allegiance)
end

---@nodiscard
---@return integer
function CBaseEntity:getCampaignAllegiance()
end

---@param allegiance integer
---@return nil
function CBaseEntity:setCampaignAllegiance(allegiance)
end

---@nodiscard
---@return boolean
function CBaseEntity:isSeekingParty()
end

---@nodiscard
---@return boolean
function CBaseEntity:getNewPlayer()
end

---@param newplayer boolean
---@return nil
function CBaseEntity:setNewPlayer(newplayer)
end

---@nodiscard
---@return boolean
function CBaseEntity:getMentor()
end

---@param mentor boolean
---@return nil
function CBaseEntity:setMentor(mentor)
end

---@nodiscard
---@return integer
function CBaseEntity:getGMLevel()
end

---@param level integer
---@return nil
function CBaseEntity:setGMLevel(level)
end

---@param level integer
---@return nil
function CBaseEntity:setVisibleGMLevel(level)
end

---@nodiscard
---@return integer
function CBaseEntity:getVisibleGMLevel()
end

---@nodiscard
---@return boolean
function CBaseEntity:getGMHidden()
end

---@param isHidden boolean
---@return nil
function CBaseEntity:setGMHidden(isHidden)
end

---@nodiscard
---@return boolean
function CBaseEntity:getWallhack()
end

function CBaseEntity:setWallhack(enable)
end

function CBaseEntity:isJailed()
end

function CBaseEntity:jail()
end

function CBaseEntity:canUseMisc(misc)
end

function CBaseEntity:getSpeed()
end

function CBaseEntity:setSpeed(speedVal)
end

function CBaseEntity:getPlaytime(shouldUpdate)
end

function CBaseEntity:getTimeCreated()
end

function CBaseEntity:getMainJob()
end

function CBaseEntity:getSubJob()
end

function CBaseEntity:changeJob(newJob)
end

function CBaseEntity:changesJob(subJob)
end

function CBaseEntity:unlockJob(JobID)
end

function CBaseEntity:hasJob(job)
end

function CBaseEntity:getMainLvl()
end

function CBaseEntity:getSubLvl()
end

function CBaseEntity:getJobLevel(JobID)
end

function CBaseEntity:setLevel(level)
end

function CBaseEntity:setsLevel(slevel)
end

function CBaseEntity:getLevelCap()
end

function CBaseEntity:setLevelCap(cap)
end

function CBaseEntity:levelRestriction(level)
end

function CBaseEntity:addJobTraits(jobID, level)
end

function CBaseEntity:getMonstrosityData()
end

function CBaseEntity:setMonstrosityData(table)
end

function CBaseEntity:getBelligerencyFlag()
end

function CBaseEntity:setBelligerencyFlag(flag)
end

function CBaseEntity:getMonstrositySize()
end

function CBaseEntity:setMonstrosityEntryData(x, y, z, rot, zoneId, mjob, sjob)
end

function CBaseEntity:getTitle()
end

function CBaseEntity:hasTitle(titleID)
end

function CBaseEntity:addTitle(titleID)
end

function CBaseEntity:setTitle(titleID)
end

function CBaseEntity:delTitle(titleID)
end

function CBaseEntity:getFame(areaObj)
end

function CBaseEntity:addFame(areaObj, fame)
end

function CBaseEntity:setFame(areaObj, fame)
end

function CBaseEntity:getFameLevel(areaObj)
end

function CBaseEntity:getRank(nation)
end

function CBaseEntity:setRank(rank)
end

function CBaseEntity:getRankPoints()
end

function CBaseEntity:addRankPoints(rankpoints)
end

function CBaseEntity:setRankPoints(rankpoints)
end

function CBaseEntity:addQuest(questLogID, questID)
end

function CBaseEntity:delCurrentQuest(questLogID, questID)
end

function CBaseEntity:delQuest(questLogID, questID)
end

function CBaseEntity:getQuestStatus(questLogID, questID)
end

function CBaseEntity:hasCompletedQuest(questLogID, questID)
end

function CBaseEntity:completeQuest(questLogID, questID)
end

function CBaseEntity:addMission(missionLogID, missionID)
end

function CBaseEntity:delMission(missionLogID, missionID)
end

function CBaseEntity:getCurrentMission(missionLogObj)
end

function CBaseEntity:hasCompletedMission(missionLogID, missionID)
end

function CBaseEntity:completeMission(missionLogID, missionID)
end

function CBaseEntity:setMissionStatus(missionLogID, arg2Obj, arg3Obj)
end

function CBaseEntity:getMissionStatus(missionLogID, missionStatusPosObj)
end

function CBaseEntity:setEminenceCompleted(recordID, arg1, arg2)
end

function CBaseEntity:getEminenceCompleted(recordID)
end

function CBaseEntity:getNumEminenceCompleted()
end

function CBaseEntity:setEminenceProgress(recordID, progress, arg2)
end

function CBaseEntity:getEminenceProgress(recordID)
end

function CBaseEntity:hasEminenceRecord(recordID)
end

function CBaseEntity:triggerRoeEvent(eventNum, reqTable)
end

function CBaseEntity:setUnityLeader(leaderID)
end

function CBaseEntity:getUnityLeader()
end

function CBaseEntity:getUnityRank(unityObj)
end

function CBaseEntity:getClaimedDeedMask()
end

function CBaseEntity:toggleReceivedDeedRewards()
end

function CBaseEntity:setClaimedDeed(deedBitNum)
end

function CBaseEntity:resetClaimedDeeds()
end

function CBaseEntity:setUniqueEvent(uniqueEventId)
end

function CBaseEntity:delUniqueEvent(uniqueEventId)
end

function CBaseEntity:hasCompletedUniqueEvent(uniqueEventId)
end

function CBaseEntity:addAssault(missionID)
end

function CBaseEntity:delAssault(missionID)
end

function CBaseEntity:getCurrentAssault()
end

function CBaseEntity:hasCompletedAssault(missionID)
end

function CBaseEntity:completeAssault(missionID)
end

function CBaseEntity:addKeyItem(keyItemID)
end

function CBaseEntity:hasKeyItem(keyItemID)
end

function CBaseEntity:delKeyItem(keyItemID)
end

function CBaseEntity:seenKeyItem(keyItemID)
end

function CBaseEntity:unseenKeyItem(keyItemID)
end

function CBaseEntity:addExp(exp)
end

function CBaseEntity:addCapacityPoints(capacity)
end

function CBaseEntity:delExp(exp)
end

function CBaseEntity:getMerit(merit)
end

function CBaseEntity:getMeritCount()
end

function CBaseEntity:setMerits(numPoints)
end

function CBaseEntity:getSpentJobPoints()
end

function CBaseEntity:getJobPointLevel(jpType)
end

function CBaseEntity:setJobPoints(amount)
end

function CBaseEntity:setCapacityPoints(amount)
end

function CBaseEntity:masterJob()
end

function CBaseEntity:getGil()
end

function CBaseEntity:addGil(gil)
end

function CBaseEntity:setGil(amount)
end

function CBaseEntity:delGil(gil)
end

function CBaseEntity:getCurrency(currencyType)
end

function CBaseEntity:addCurrency(currencyType, amount, maxObj)
end

function CBaseEntity:setCurrency(currencyType, amount)
end

function CBaseEntity:delCurrency(currencyType, amount)
end

function CBaseEntity:getCP()
end

function CBaseEntity:addCP(cp)
end

function CBaseEntity:delCP(cp)
end

function CBaseEntity:getSeals(sealType)
end

function CBaseEntity:addSeals(points, sealType)
end

function CBaseEntity:delSeals(points, sealType)
end

function CBaseEntity:getAssaultPoint(region)
end

function CBaseEntity:addAssaultPoint(region, points)
end

function CBaseEntity:delAssaultPoint(region, points)
end

function CBaseEntity:addGuildPoints(guildID, slotID)
end

function CBaseEntity:getHP()
end

function CBaseEntity:getHPP()
end

function CBaseEntity:getMaxHP()
end

function CBaseEntity:getBaseHP()
end

function CBaseEntity:addHP(hpAdd)
end

function CBaseEntity:addHPLeaveSleeping(hpAdd)
end

function CBaseEntity:setHP(value)
end

function CBaseEntity:restoreHP(restoreAmt)
end

function CBaseEntity:delHP(delAmt)
end

function CBaseEntity:takeDamage(damage, attacker, atkType, dmgType, flags)
end

function CBaseEntity:hideHP(value)
end

function CBaseEntity:getDeathType()
end

function CBaseEntity:setDeathType(value)
end

function CBaseEntity:getMP()
end

function CBaseEntity:getMPP()
end

function CBaseEntity:getMaxMP()
end

function CBaseEntity:getBaseMP()
end

function CBaseEntity:addMP(amount)
end

function CBaseEntity:setMP(value)
end

function CBaseEntity:restoreMP(amount)
end

function CBaseEntity:delMP(amount)
end

function CBaseEntity:getTP()
end

function CBaseEntity:addTP(amount)
end

function CBaseEntity:setTP(value)
end

function CBaseEntity:delTP(amount)
end

function CBaseEntity:updateHealth()
end

function CBaseEntity:getAverageItemLevel()
end

function CBaseEntity:capSkill(skill)
end

function CBaseEntity:capAllSkills()
end

function CBaseEntity:getSkillLevel(skillId)
end

function CBaseEntity:setSkillLevel(SkillID, SkillAmount)
end

function CBaseEntity:getMaxSkillLevel(level, jobId, skillId)
end

function CBaseEntity:getSkillRank(rankID)
end

function CBaseEntity:setSkillRank(skillID, newrank)
end

function CBaseEntity:getCharSkillLevel(skillID)
end

function CBaseEntity:addLearnedWeaponskill(wsUnlockId)
end

function CBaseEntity:hasLearnedWeaponskill(wsUnlockId)
end

function CBaseEntity:delLearnedWeaponskill(wsUnlockId)
end

function CBaseEntity:trySkillUp(skill, level, forceSkillUpObj, useSubSkillObj)
end

function CBaseEntity:addWeaponSkillPoints(slotID, points)
end

function CBaseEntity:addLearnedAbility(abilityID)
end

function CBaseEntity:hasLearnedAbility(abilityID)
end

function CBaseEntity:canLearnAbility(abilityID)
end

function CBaseEntity:delLearnedAbility(abilityID)
end

function CBaseEntity:addSpell(spellID, ...)
end

function CBaseEntity:hasSpell(spellID)
end

function CBaseEntity:canLearnSpell(spellID)
end

function CBaseEntity:delSpell(spellID)
end

function CBaseEntity:recalculateSkillsTable()
end

function CBaseEntity:recalculateAbilitiesTable()
end

function CBaseEntity:getEntitiesInRange(PLuaEntityTarget, ...)
end

function CBaseEntity:getParty()
end

function CBaseEntity:getPartyWithTrusts()
end

function CBaseEntity:getPartySize(arg0)
end

function CBaseEntity:hasPartyJob(job)
end

function CBaseEntity:getPartyMember(member, allianceparty)
end

function CBaseEntity:getPartyLeader()
end

function CBaseEntity:getLeaderID()
end

function CBaseEntity:getPartyLastMemberJoinedTime()
end

function CBaseEntity:forMembersInRange(range, luaFunction)
end

function CBaseEntity:addPartyEffect(...)
end

function CBaseEntity:hasPartyEffect(effectid)
end

function CBaseEntity:removePartyEffect(effectid)
end

function CBaseEntity:getAlliance()
end

function CBaseEntity:getAllianceSize()
end

function CBaseEntity:reloadParty()
end

function CBaseEntity:disableLevelSync()
end

function CBaseEntity:isLevelSync()
end

function CBaseEntity:checkSoloPartyAlliance()
end

function CBaseEntity:checkKillCredit(PLuaBaseEntity, minRange)
end

function CBaseEntity:checkDifficulty(PLuaBaseEntity)
end

function CBaseEntity:getInstance()
end

function CBaseEntity:setInstance(PLuaInstance)
end

function CBaseEntity:createInstance(instanceID)
end

function CBaseEntity:instanceEntry(PLuaBaseEntity, response)
end

---@deprecated
function CBaseEntity:isInAssault()
end

function CBaseEntity:getConfrontationEffect()
end

function CBaseEntity:copyConfrontationEffect(targetID)
end

function CBaseEntity:getBattlefield()
end

function CBaseEntity:getBattlefieldID()
end

function CBaseEntity:registerBattlefield(arg0, arg1, arg2, arg3)
end

function CBaseEntity:battlefieldAtCapacity(battlefieldID)
end

function CBaseEntity:enterBattlefield(area)
end

function CBaseEntity:leaveBattlefield(leavecode)
end

function CBaseEntity:isInDynamis()
end

function CBaseEntity:setEnteredBattlefield(entered)
end

function CBaseEntity:hasEnteredBattlefield()
end

function CBaseEntity:isAlive()
end

function CBaseEntity:isDead()
end

function CBaseEntity:hasRaiseTractorMenu()
end

function CBaseEntity:sendRaise(raiseLevel)
end

function CBaseEntity:sendReraise(raiseLevel)
end

function CBaseEntity:sendTractor(xPos, yPos, zPos, rotation)
end

function CBaseEntity:allowSendRaisePrompt()
end

function CBaseEntity:contdown(secondsObj)
end

function CBaseEntity:objectiveUtility(obj)
end

function CBaseEntity:enableEntities(obj)
end

function CBaseEntity:independentAnimation(PTarget, animId, mode)
end

function CBaseEntity:engage(requestedTarget)
end

function CBaseEntity:isEngaged()
end

function CBaseEntity:disengage()
end

function CBaseEntity:timer(ms, func)
end

function CBaseEntity:queue(ms, func)
end

function CBaseEntity:addRecast(recastCont, recastID, duration)
end

function CBaseEntity:hasRecast(rType, recastID, arg2)
end

function CBaseEntity:resetRecast(rType, recastID)
end

function CBaseEntity:resetRecasts()
end

function CBaseEntity:addListener(eventName, identifier, func)
end

function CBaseEntity:removeListener(identifier)
end

function CBaseEntity:triggerListener(eventName, args)
end

function CBaseEntity:getEntity(targetID)
end

function CBaseEntity:canChangeState()
end

function CBaseEntity:wakeUp()
end

function CBaseEntity:setBattleID(battleID)
end

function CBaseEntity:getBattleID()
end

function CBaseEntity:recalculateStats()
end

function CBaseEntity:checkImbuedItems()
end

function CBaseEntity:isDualWielding()
end

function CBaseEntity:isUsingH2H()
end

function CBaseEntity:getBaseWeaponDelay(slot)
end

function CBaseEntity:getBaseDelay()
end

function CBaseEntity:getBaseRangedDelay()
end

function CBaseEntity:checkLiementAbsorb(damageType)
end

function CBaseEntity:getCE(target)
end

function CBaseEntity:getVE(target)
end

function CBaseEntity:setCE(target, amount)
end

function CBaseEntity:setVE(target, amount)
end

function CBaseEntity:addEnmity(PEntity, CE, VE)
end

function CBaseEntity:lowerEnmity(PEntity, percent)
end

function CBaseEntity:updateEnmity(PEntity)
end

function CBaseEntity:transferEnmity(entity, percent, range)
end

function CBaseEntity:updateEnmityFromDamage(PEntity, damage)
end

function CBaseEntity:updateEnmityFromCure(PEntity, amount, fixedCE, fixedVE)
end

function CBaseEntity:resetEnmity(PEntity)
end

function CBaseEntity:updateClaim(entity)
end

function CBaseEntity:hasEnmity()
end

function CBaseEntity:getNotorietyList()
end

function CBaseEntity:setClaimable(claimable)
end

function CBaseEntity:getClaimable()
end

function CBaseEntity:clearEnmityForEntity(PEntity)
end

function CBaseEntity:addStatusEffect(...)
end

function CBaseEntity:addStatusEffectEx(...)
end

function CBaseEntity:getStatusEffect(StatusID, SubType)
end

function CBaseEntity:getStatusEffects()
end

function CBaseEntity:getStatusEffectElement(statusId)
end

function CBaseEntity:canGainStatusEffect(effect, powerObj)
end

function CBaseEntity:hasStatusEffect(StatusID, SubType)
end

function CBaseEntity:hasStatusEffectByFlag(StatusID)
end

function CBaseEntity:countEffect(StatusID)
end

function CBaseEntity:countEffectWithFlag(flag)
end

function CBaseEntity:delStatusEffect(StatusID, SubType)
end

function CBaseEntity:delStatusEffectsByFlag(flag, silent)
end

function CBaseEntity:delStatusEffectSilent(StatusID)
end

function CBaseEntity:eraseStatusEffect()
end

function CBaseEntity:eraseAllStatusEffect()
end

function CBaseEntity:dispelStatusEffect(flagObj)
end

function CBaseEntity:dispellAllStatusEffect(flagObj)
end

function CBaseEntity:stealStatusEffect(PTargetEntity, flagObj)
end

function CBaseEntity:addMod(type, amount)
end

function CBaseEntity:getMod(modID)
end

function CBaseEntity:setMod(modID, value)
end

function CBaseEntity:delMod(modID, value)
end

function CBaseEntity:getMaxGearMod(modId)
end

function CBaseEntity:addLatent(condID, conditionValue, mID, modValue)
end

function CBaseEntity:delLatent(condID, conditionValue, mID, modValue)
end

function CBaseEntity:hasAllLatentsActive(slot)
end

function CBaseEntity:fold()
end

function CBaseEntity:doWildCard(PEntity, total)
end

function CBaseEntity:doRandomDeal(PTarget)
end

function CBaseEntity:addCorsairRoll(casterJob, bustDuration, effectID, power, tick, duration, arg6, arg7, arg8)
end

function CBaseEntity:hasCorsairEffect()
end

function CBaseEntity:hasBustEffect(id)
end

function CBaseEntity:numBustEffects()
end

function CBaseEntity:healingWaltz()
end

function CBaseEntity:addBardSong(PEntity, effectID, power, tick, duration, SubType, subPower, tier)
end

function CBaseEntity:charm(target)
end

function CBaseEntity:uncharm()
end

function CBaseEntity:addBurden(element, burden)
end

function CBaseEntity:getOverloadChance(element)
end

function CBaseEntity:setStatDebilitation(statDebil)
end

function CBaseEntity:getStat(statId, ...)
end

function CBaseEntity:getACC()
end

function CBaseEntity:getEVA()
end

function CBaseEntity:getRACC()
end

function CBaseEntity:getRATT()
end

function CBaseEntity:getIlvlMacc()
end

function CBaseEntity:getIlvlSkill()
end

function CBaseEntity:getIlvlParry()
end

function CBaseEntity:isSpellAoE(spellId)
end

function CBaseEntity:physicalDmgTaken(damage, ...)
end

function CBaseEntity:magicDmgTaken(damage, ...)
end

function CBaseEntity:rangedDmgTaken(damage, ...)
end

function CBaseEntity:breathDmgTaken(damage)
end

function CBaseEntity:handleAfflatusMiseryDamage(damage)
end

function CBaseEntity:isWeaponTwoHanded()
end

function CBaseEntity:getWeaponDmg()
end

function CBaseEntity:getWeaponDmgRank()
end

function CBaseEntity:getOffhandDmg()
end

function CBaseEntity:getOffhandDmgRank()
end

function CBaseEntity:getRangedDmg()
end

function CBaseEntity:getRangedDmgRank()
end

function CBaseEntity:getAmmoDmg()
end

function CBaseEntity:getWeaponHitCount(offhand)
end

function CBaseEntity:removeAmmo()
end

function CBaseEntity:getWeaponSkillLevel(slotID)
end

function CBaseEntity:getWeaponDamageType(slotID)
end

function CBaseEntity:getWeaponSkillType(slotID)
end

function CBaseEntity:getWeaponSubSkillType(slotID)
end

function CBaseEntity:getWSSkillchainProp()
end

function CBaseEntity:takeWeaponskillDamage(attacker, damage, atkType, dmgType, slot, primary, tpMultiplier, bonusTP, targetTPMultiplier)
end

function CBaseEntity:takeSpellDamage(caster, spell, damage, atkType, dmgType)
end

function CBaseEntity:takeSwipeLungeDamage(caster, damage, atkType, dmgType)
end

function CBaseEntity:checkDamageCap(damage)
end

function CBaseEntity:spawnPet(arg0)
end

function CBaseEntity:despawnPet()
end

function CBaseEntity:spawnTrust(trustId)
end

function CBaseEntity:clearTrusts()
end

function CBaseEntity:getTrustID()
end

function CBaseEntity:trustPartyMessage(messageId)
end

function CBaseEntity:addSimpleGambit(targ, cond, condition_arg, react, select, selectorArg, retry)
end

function CBaseEntity:removeSimpleGambit(id)
end

function CBaseEntity:removeAllSimpleGambits()
end

function CBaseEntity:setTrustTPSkillSettings(trigger, select, value)
end

function CBaseEntity:hasValidJugPetItem()
end

function CBaseEntity:hasPet()
end

function CBaseEntity:hasJugPet()
end

function CBaseEntity:getPet()
end

function CBaseEntity:getPetID()
end

function CBaseEntity:isAutomaton()
end

function CBaseEntity:isAvatar()
end

function CBaseEntity:getMaster()
end

function CBaseEntity:getPetElement()
end

function CBaseEntity:setPet(petObj)
end

function CBaseEntity:getMinimumPetLevel()
end

function CBaseEntity:getPetName()
end

function CBaseEntity:setPetName(pType, value, arg2)
end

function CBaseEntity:registerChocobo(value)
end

function CBaseEntity:getCharmChance(target, mods)
end

function CBaseEntity:charmPet(target)
end

function CBaseEntity:petAttack(PEntity)
end

function CBaseEntity:petAbility(abilityID)
end

function CBaseEntity:petRetreat()
end

function CBaseEntity:familiar()
end

function CBaseEntity:addPetMod(modID, amount)
end

function CBaseEntity:setPetMod(modID, amount)
end

function CBaseEntity:delPetMod(modID, amount)
end

function CBaseEntity:hasAttachment(itemID)
end

function CBaseEntity:getAutomatonName()
end

function CBaseEntity:getAutomatonFrame()
end

function CBaseEntity:getAutomatonHead()
end

function CBaseEntity:unlockAttachment(itemID)
end

function CBaseEntity:getActiveManeuverCount()
end

function CBaseEntity:removeOldestManeuver()
end

function CBaseEntity:removeAllManeuvers()
end

function CBaseEntity:getAttachment(slotId)
end

function CBaseEntity:getAttachments()
end

function CBaseEntity:updateAttachments()
end

function CBaseEntity:reduceBurden(percentReduction, intReductionObj)
end

function CBaseEntity:isExceedingElementalCapacity()
end

function CBaseEntity:getAllRuneEffects()
end

function CBaseEntity:getActiveRuneCount()
end

function CBaseEntity:getHighestRuneEffect()
end

function CBaseEntity:getNewestRuneEffect()
end

function CBaseEntity:removeOldestRune()
end

function CBaseEntity:removeNewestRune()
end

function CBaseEntity:removeAllRunes()
end

function CBaseEntity:setMobLevel(level)
end

function CBaseEntity:getEcosystem()
end

function CBaseEntity:getSuperFamily()
end

function CBaseEntity:getFamily()
end

function CBaseEntity:isMobType(mobType)
end

function CBaseEntity:isUndead()
end

function CBaseEntity:isNM()
end

function CBaseEntity:getModelSize()
end

function CBaseEntity:setMeleeRange(range)
end

function CBaseEntity:setMobFlags(flags, mobId)
end

function CBaseEntity:getMobFlags()
end

function CBaseEntity:setNpcFlags(flags)
end

function CBaseEntity:spawn(despawnSec, respawnSec)
end

function CBaseEntity:isSpawned()
end

function CBaseEntity:getSpawnPos()
end

function CBaseEntity:setSpawn(x, y, z, rot)
end

function CBaseEntity:getRespawnTime()
end

function CBaseEntity:setRespawnTime(seconds)
end

function CBaseEntity:instantiateMob(groupID)
end

function CBaseEntity:hasTrait(traitID)
end

function CBaseEntity:hasImmunity(immunityID)
end

function CBaseEntity:addImmunity(immunityID)
end

function CBaseEntity:delImmunity(immunityID)
end

function CBaseEntity:setAggressive(agressive)
end

function CBaseEntity:setTrueDetection(truedetection)
end

function CBaseEntity:setUnkillable(unkillable)
end

function CBaseEntity:setUntargetable(untargetable)
end

function CBaseEntity:getUntargetable()
end

function CBaseEntity:setIsAggroable(isAggroable)
end

function CBaseEntity:isAggroable()
end

function CBaseEntity:setDelay(delay)
end

function CBaseEntity:setDamage(damage)
end

function CBaseEntity:hasSpellList()
end

function CBaseEntity:setSpellList(spellList)
end

function CBaseEntity:setAutoAttackEnabled(state)
end

function CBaseEntity:setMagicCastingEnabled(state)
end

function CBaseEntity:setMobAbilityEnabled(state)
end

function CBaseEntity:setMobSkillAttack(listId)
end

function CBaseEntity:getMobMod(mobModID)
end

function CBaseEntity:setMobMod(mobModID, value)
end

function CBaseEntity:addMobMod(mobModID, value)
end

function CBaseEntity:delMobMod(mobModID, value)
end

function CBaseEntity:getBattleTime()
end

function CBaseEntity:getBehaviour()
end

function CBaseEntity:setBehaviour(behavior)
end

function CBaseEntity:getRoamFlags()
end

function CBaseEntity:setRoamFlags(newRoamFlags)
end

function CBaseEntity:getTarget()
end

function CBaseEntity:updateTarget()
end

function CBaseEntity:getEnmityList()
end

function CBaseEntity:getTrickAttackChar(PLuaBaseEntity)
end

function CBaseEntity:actionQueueEmpty()
end

function CBaseEntity:castSpell(spell, entity)
end

function CBaseEntity:useJobAbility(skillID, pet)
end

function CBaseEntity:useMobAbility(...)
end

function CBaseEntity:getAbilityDistance(skillID)
end

function CBaseEntity:hasTPMoves()
end

function CBaseEntity:drawIn(...)
end

function CBaseEntity:weaknessTrigger(level)
end

function CBaseEntity:restoreFromChest(PLuaBaseEntity, restoreType)
end

function CBaseEntity:hasPreventActionEffect()
end

function CBaseEntity:stun(milliseconds)
end

function CBaseEntity:untargetableAndUnactionable(milliseconds)
end

function CBaseEntity:getPool()
end

function CBaseEntity:getDropID()
end

function CBaseEntity:setDropID(dropID)
end

function CBaseEntity:addTreasure(itemID, arg1, arg2)
end

function CBaseEntity:getStealItem()
end

function CBaseEntity:getDespoilItem()
end

function CBaseEntity:getDespoilDebuff(itemID)
end

function CBaseEntity:itemStolen()
end

function CBaseEntity:getTHlevel()
end

function CBaseEntity:getAvailableTraverserStones()
end

function CBaseEntity:getTraverserEpoch()
end

function CBaseEntity:setTraverserEpoch()
end

function CBaseEntity:getClaimedTraverserStones()
end

function CBaseEntity:addClaimedTraverserStones(numStones)
end

function CBaseEntity:setClaimedTraverserStones(totalStones)
end

function CBaseEntity:getHistory(index)
end

function CBaseEntity:getChocoboRaisingInfo()
end

function CBaseEntity:setChocoboRaisingInfo()
end

function CBaseEntity:deleteRaisedChocobo()
end

function CBaseEntity:clearActionQueue()
end

function CBaseEntity:clearTimerQueue()
end

function CBaseEntity:setMannequinPose(itemID, race, pose)
end

function CBaseEntity:getMannequinPose(itemID)
end

function CBaseEntity:addPacketMod(packetId, offset, value)
end

function CBaseEntity:clearPacketMods()
end
