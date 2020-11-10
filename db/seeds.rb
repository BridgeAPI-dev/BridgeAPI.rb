def test_url
  "doggoapi.io/" + Bridge.generate_inbound_url
end

bridge = Bridge.create(name: 'My First Bridge', payload: '', inbound_url: Bridge.generate_inbound_url, outbound_url: test_url, method: 'POST', retries: 5, delay: 15)

bridge.env_vars << EnvironmentVariable.create(key: 'database', value: 'a102345ij2')
bridge.env_vars << EnvironmentVariable.create(key: 'database_password', value: 'supersecretpasswordwow')
bridge.headers << Header.create(key: 'X_API_KEY', value: 'ooosecrets')
bridge.headers << Header.create(key: 'Authentication', value: 'Bearer 1oij2oubviu3498')


5.times do 
  bridge.events << Event.create(completed: false, outbound_url: bridge.outbound_url, inbound_url: test_url, data: '', status_code: 300)
end