-- call modimport("path_from_modroot/util") and all the non-locals here will be ready to use.

-- [[ CONSTANTS ]]
_G = GLOBAL 

-- [[ C++ ENGINE STUFF ]]
TheNet = _G.TheNet

-- [[ GLOBAL TABLES ]]
STRINGS = _G.STRINGS

-- [[ EMPTY BUT INITIALIZED GLOBAL TABLES ]]
-- these empty tables are initialized and will eventually be populated by the game.
AllPlayers = _G.AllPlayers
Ents = _G.Ents

-- some tables aren't initialized at the time the mod is being compiled, such as ThePlayer, TheWorld, etc. see main.lua.
-- other tables like Prefabs can't be declared here, for some reason?

-- [[ GLOBAL FUNCTIONS ]]
SpawnPrefab = _G.SpawnPrefab
debug = _G.debug
unpack = _G.unpack -- not within mod env so gotta call global
dumptable = _G.dumptable -- DST specific

-- [[ SHORTHAND FUNCTIONS ]]
gsub = string.gsub
stringf = string.format -- i use string.format a ton, so this seems reasonable?
function printf(fmt, ...) -- stands for "Print Format".
	print(stringf(fmt, ...)) 
end 

-- [[ DEBUG FUNCTIONS ]]
-- tbh this is all i have LMAO
prettyname = "[[DEBUG]] MY MOD NAME: "
function printd(fmt, ...)
  printf(prettyname..fmt, ...)
end

-- ==================================
-- [[ EXAMPLE UTIL FUNCTIONS I USE ]]
-- ==================================
function GetShard()
    local TheWorld = _G.TheWorld -- TheWorld doesn't exist at compile time, so declare it within the fn
    local shard = "This Shard" -- default if somehow none of the below match
    if TheWorld:HasTag("forest") then
        shard = "Surface"
    elseif TheWorld:HasTag("cave") then
        shard = "Caves"
    elseif TheWorld:HasTag("island") then -- IA support :D
        shard = "Shipwrecked"
    elseif TheWorld:HasTag("volcano") then
        shard = "Volcano"
    end
    return string.upper(shard)
end

function NoInput(check)
    local msg = prettyname.." Please input a '%s' for the command to work with!"
    if check == "prefab" then
        msg = stringf(msg, "prefab")
    elseif check == "tendency" then
        msg = stringf(msg, "Beefalo tendency")
    elseif check == "player" then
        msg = stringf(msg, "Player number")
	else
		msg = "Seems like I forgot a NoInput check for another kind of variable!"
    end
    print(msg)
end

function ValidPlayerNum(num)
	local invalid = prettyname.." Player number '%d'"
    if not (type(num) == "number") then
		invalid = gsub(invalid, "%d", "input")
		invalid = invalid.." is not a number value!"
        print(invalid)
        return nil
    elseif num == 0 or (num > #AllPlayers) or (num < 0) then 
        invalid = invalid.." is outside the current playerlist."
        printf(invalid, num)
        return nil
    end
    return true
end

function DisplayName(prefab)
    local upper = string.upper(prefab) 
	local invalid = prettyname.." Prefab '%s' has no Display Name!"
    local name = ""
    for k,v in pairs(STRINGS.NAMES) do
        if k == upper then 
            name = v
            return name
        end
    end
    printf(invalid, prefab)
    name =  "MISSING NAME" 
    return name
end

function IsInvItem(prefab)
    local prefab = string.lower(prefab)
	local invalid = prettyname.." Prefab '%s' is not an inventory item!"
    local item = SpawnPrefab(prefab) --thanks to Anagram and HarryPPPotter for helping here!
    if item.components.inventoryitem == nil then
        printf(invalid, prefab)
        item:Remove() -- this is so stupid but whatever
        return nil
    end 
    item:Remove()
    return true
end

function ValidPrefab(prefab)
	local invalid = prettyname.." Prefab input '%s'"
    if not (type(prefab) == "string") then
		prefab = tostring(prefab)
        printf(invalid.." is not a string!", prefab)
        return nil
    end
    -- simply using Prefabs = _G.Prefabs at the top returns nil for some reason, 
    -- i thought it gets populated tho? strange
    local lower = string.lower(prefab)
    if _G.Prefabs[lower] == nil then 
        printf(invalid.." is not an existing prefab!", prefab)
        return nil 
    end --thanks to Atoba Azul and thegreatmanagement for the Prefabs[prefab] check line!
    return true
end

function GiveInInventory(player, prefab, count)
    local prefab = string.lower(prefab)
    for i=1, count do
        player.components.inventory:GiveItem(SpawnPrefab(prefab))
    end
end

-- again, call 'modimport("path_to_util/util")' to use this!
