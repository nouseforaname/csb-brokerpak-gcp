package brokers

import "csbbrokerpakgcp/acceptance-tests/helpers/cf"

func (b *Broker) Delete() {
	cf.Run("delete-service-broker", b.Name, "-f")
	b.app.Delete()
}
