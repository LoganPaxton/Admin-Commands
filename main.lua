--------------------------------
--- Loganvxr's Admin Wrapper ---
---   Created on: 3/29/25    ---
---  Last Updated: Never!    ---
---     Version: 0.1.0       ---
--------------------------------

-- CHANGE LOG --
-- V0.1.0 - Released first version

-- PLANNED UPDATES --
-- V0.2.0 - Add in vip and admin commands
-- V0.3.0 - Add in command levels, and command gamepasses

-- BUG REPORTS --
-- If you find any bugs please report the ASAP to loganvxr on Discord!

-- MAIN CONFIG --

local commands = {
    ["to"] = function (sender, target)
        -- Change player's CFrame to the player they would like to teleport to
        print("Moving " .. sender .. " to player ".. target)
    end
} -- Add more commands as you see fit.
local prefix = "!" -- Change the prefix to anything. !, ;, :, and ? are recommended prefixes

-- GAMEPASSES --

local vip_gamepass = nil -- Gamepass ID, if set to nil will make this level of commands NOT able to be bought
local admin_gamepass = nil -- Gamepass ID, if set to nil will make this level of commands NOT able to be bought
local mod_gamepass = nil -- Gamepass ID, if set to nil will make this level of commands NOT able to be bought

local vip_access = 100 -- Max is 255 which gives access to all commands, minimum is 1 giving access to very limited commands
local admin_access = 155 -- Max is 255 which gives access to all commands, minimum is 1 giving access to very limited commands
local mod_access = 200 -- Max is 255 which gives access to all commands, minimum is 1 giving access to very limited commands

-- OP COMMAND REQUIREMENTS --

-- Only powerful commands such as sit, jump, ban, kick, ect. will be listed here

local ban_access = 255 -- Max is 255 which restricts this command to owner-only, minimum is 0 which gives access to anyone.
local kick_access = 200 -- Max is 255 which restricts this command to owner-only, minimum is 0 which gives access to anyone.
local sit_access = 100 -- Max is 255 which restricts this command to owner-only, minimum is 0 which gives access to anyone.
local jump_access = 100 -- Max is 255 which restricts this command to owner-only, minimum is 0 which gives access to anyone.
local pm_access = 100 -- Max is 255 which restricts this command to owner-only, minimum is 0 which gives access to anyone.

-- USER SETTINGS --

local owner = nil -- Set this variable to the owner's ID, if set to null means no one is the owner
local moderators = {0} -- Add more user ID(s) as you deem fit

-- END SETTINGS --

-- MAIN FUNCTIONS --

-- LOCAL VARIABLES --

local plr_chatmsg, sender_uid

-- END LOCAL VARIABLES --

local function split(str, sep)
    local result = {}
    for word in str:gmatch("([^" .. sep .. "]+)") do
        table.insert(result, word)
    end
    return result
end


local function parse_command(plr_chatmsg, sender_uid)
    if string.sub(plr_chatmsg, 1, 1) == "!" then
        local trimmed_chatmsg = string.sub(plr_chatmsg, 2) -- Remove "!"
        local args = split(trimmed_chatmsg, " ") -- Split message into words
        local command_name = args[1] -- First word is the command
        table.remove(args, 1) -- Remove the command name from args
        local command_executed = false

        for _, user_id in ipairs(moderators) do
            if user_id == sender_uid then
                local command = commands[command_name]
                if command then
                    command(sender_uid, table.unpack(args)) -- Execute function with remaining arguments
                    command_executed = true
                    break
                end
            end
        end

        if not command_executed then
            if sender_uid == owner then
                local command = commands[command_name]
                if command then
                    command(sender_uid, table.unpack(args)) -- Execute function with remaining arguments
                    command_executed = true
                end
            end
        end

        if not command_executed then
            print("Command not found or no permission.")
        end
    end
end

-- END MAIN FUNCTIONS --

-- USAGE --

-- To begin using the admin commands, you first need to make a player.chatted event function.
-- You then need to set 2 variables, plr_chatmsg, and sender_uid.
-- Please note that plr_chatmsg, and sender_uid are global variables within this script, and do not need to be initalized.
-- Then inside of that execute the parse_command function.

-- ADDING CUSTOM COMMANDS --

-- To add custom commands, find the local variable named "commands", and add a new key-value entry, make the value a function, and add your custom code inside of it.
-- Set the key entry to the name of the command you want the player to execute (e.g., !to)
