def test_url
  "doggoapi.io/" + String(rand).split('.')[1]
end

user = User.create(email: 'admin@bridge.io', password: 'password', notifications: false)
user2 = User.create(email: 'tester@bridge.io', password: 'password', notifications: false)

bridge = Bridge.create(
  user: user,
  name: 'My First Bridge', 
  payload: '',  
  outbound_url: test_url, 
  method: 'POST', 
  retries: 5, 
  delay: 15,
  data: '{}'
)


bridge.environment_variables << EnvironmentVariable.create(key: 'database', value: 'a102345ij2')
bridge.environment_variables << EnvironmentVariable.create(key: 'database_password', value: 'supersecretpasswordwow')
bridge.headers << Header.create(key: 'X_API_KEY', value: 'ooosecrets')
bridge.headers << Header.create(key: 'Authentication', value: 'Bearer &&&&&&&&&&&&&&&&')

bridge2 = Bridge.create(
  user: user2,
  name: 'My Second Bridge', 
  payload: '',  
  outbound_url: test_url, 
  method: 'PATCH', 
  retries: 0, 
  delay: 0,
  data: { payload: {}, testPayload: {}}
)

bridge2.environment_variables << EnvironmentVariable.create(key: 'database', value: 'z9992374623')
bridge2.environment_variables << EnvironmentVariable.create(key: 'database_password', value: '@@@!++#*!@')
bridge2.headers << Header.create(key: 'X_API_KEY', value: 'returntheslab')
bridge2.headers << Header.create(key: 'Authentication', value: 'Bearer *************')


5.times do 
  bridge.events << Event.create(completed: false, outbound_url: bridge.outbound_url, inbound_url: test_url, data: '', status_code: 300)
  bridge2.events << Event.create(completed: false, outbound_url: bridge2.outbound_url, inbound_url: test_url, data: '', status_code: 302)
end