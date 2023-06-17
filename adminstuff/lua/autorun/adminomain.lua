
	admino = {["adminoverides"] = {}, ["adminapplycreate"] = {},}

if SERVER then
util.AddNetworkString( "admino_onclient" )
end

if CLIENT then
net.Receive( "admino_onclient", function()

	local data = string.Split( net.ReadString(), "|" )

if data[1] == "create" then
if data[3] == "true" then admino["adminoverides"][data[2]] = true end
if data[3] == "false" then admino["adminoverides"][data[2]] = false end
end

if data[1] == "remove" then
	admino["adminoverides"][data[2]] = nil
end
   
if data[1] == "removeall" then
table.Empty( admino["adminoverides"] )
end

if data[1] == "commandapply" then
LocalPlayer():ConCommand( data[2] )
end  
  
if data[1] == "funcapply" then
_G[data[2]]( LocalPlayer() )
   end
end)

function admino.InternalClientGet( class )
if isstring( class ) == true then
if admino["adminoverides"][class] ~= nil then

return admino["adminoverides"][class] 

         end
      end
   end
end

if SERVER then	
function admino.InternalServerGet( class, client )
if isstring( class ) == true then
if IsValid( client ) == true then

if admino["adminoverides"][tostring( client:EntIndex() )] ~= nil then
if admino["adminoverides"][tostring( client:EntIndex() )][class] ~= nil then

return admino["adminoverides"][tostring( client:EntIndex() )][class]

            end
	     end
      end
   end
end
	
function admino.Add( class, isadmin, client )
if isstring( class ) == true then
if client == nil then

	local isadminb = "nil"
	
if isadmin == true then isadminb = "true" end
if isadmin == false then isadminb = "false" end
	
for k,v in pairs (player.GetAll()) do
if admino["adminoverides"][tostring( v:EntIndex() )] == nil then admino["adminoverides"][tostring( v:EntIndex() )] = {} end
admino["adminoverides"][tostring( v:EntIndex() )][class] = isadmin
end

net.Start( "admino_onclient" )
net.WriteString( "create|"..class.."|"..isadminb ) 
net.Broadcast()

else
	
	local isadminb = "nil"
	
if admino["adminoverides"][tostring( client:EntIndex() )] == nil then admino["adminoverides"][tostring( client:EntIndex() )] = {} end
admino["adminoverides"][tostring( client:EntIndex() )][class] = isadmin
	
if isadmin == true then isadminb = "true" end
if isadmin == false then isadminb = "false" end

net.Start( "admino_onclient" )
net.WriteString( "create|"..class.."|"..isadminb ) 
net.Send( client )

	  end
   end
end

function admino.Remove( class, client )
if class == nil then
if client == nil then

net.Start( "admino_onclient" )
net.WriteString( "removeall" ) 
net.Broadcast()

table.Empty( admino["adminoverides"] )

else

net.Start( "admino_onclient" )
net.WriteString( "removeall" ) 
net.Send( client )

table.Empty( admino["adminoverides"][tostring( client:EntIndex() )]  )

   end
end

if isstring( class ) == true then
if client == nil then

net.Start( "admino_onclient" )
net.WriteString( "remove|"..class ) 
net.Broadcast()

for k,v in pairs (player.GetAll()) do
if admino["adminoverides"][tostring( v:EntIndex() )] == nil then admino["adminoverides"][tostring( v:EntIndex() )] = {} end
admino["adminoverides"][tostring( v:EntIndex() )][class] = nil
end

else

admino["adminoverides"][tostring( client:EntIndex() )][class] = nil

net.Start( "admino_onclient" )
net.WriteString( "remove|"..class ) 
net.Send( client )

      end
   end
end

function admino.ApplyCreate( aname, side, etype )
admino["adminapplycreate"][table.maxn( admino["adminapplycreate"] ) +1] = {["name"]=aname, ["side"]=side, ["type"]=etype,}
end

function admino.Apply( client )
if client == nil then
for z = 1, table.maxn( admino["adminapplycreate"] ) do

if admino["adminapplycreate"][z]["type"] == "command" then
if admino["adminapplycreate"][z]["side"] == "server" then
for k,v in pairs (player.GetAll()) do
v:ConCommand( admino["adminapplycreate"][z]["name"] ) 
   end
end

if admino["adminapplycreate"][z]["side"] == "client" then

net.Start( "admino_onclient" )
net.WriteString( "commandapply|"..admino["adminapplycreate"][z]["name"] ) 
net.Broadcast()
               
   end 
end

if admino["adminapplycreate"][z]["type"] == "function" then
if admino["adminapplycreate"][z]["side"] == "server" then
_G[data[z]]( "*" )
end

if admino["adminapplycreate"][z]["side"] == "client" then
net.Start( "admino_onclient" )
net.WriteString( "funcapply|"..admino["adminapplycreate"][z]["name"] ) 
net.Broadcast()

      end
   end
end

else

for z = 1, table.maxn( admino["adminapplycreate"] ) do

if admino["adminapplycreate"][z]["type"] == "command" then
if admino["adminapplycreate"][z]["side"] == "server" then
client:ConCommand( admino["adminapplycreate"][z]["name"] ) 
end

if admino["adminapplycreate"][z]["side"] == "client" then

net.Start( "admino_onclient" )
net.WriteString( "commandapply|"..admino["adminapplycreate"][z]["name"] ) 
net.Send( client )
               
   end
end

if admino["adminapplycreate"][z]["type"] == "function" then
if admino["adminapplycreate"][z]["side"] == "server" then
_G[data[z]]( client )
end

if admino["adminapplycreate"][z]["side"] == "client" then

net.Start( "admino_onclient" )
net.WriteString( "funcapply|"..admino["adminapplycreate"][z]["name"] ) 
net.Send( client )
               
			   end
            end
         end
      end
   end
end

