import { Card } from "compositions";
import {
  IconClock,
  IconDollarSign,
  IconHeadphones,
  IconSettings,
  IconShield,
  IconZap,
} from "icons";
import { Flex, Section } from "layout";
import { Text, TextContentHeading } from "primitives";

export function Demo() {
  return (
    <Section padding="1600">
      <Flex direction="column" gap="1200">
        <TextContentHeading
          heading="Revolutionary Audio Experience"
          subheading="Experience the future of wireless technology with premium sound quality and seamless connectivity"
        />
        <Flex direction="row" gap="1600" wrap type="third">
          <Card
            asset={<IconZap />}
            padding="600"
            direction="horizontal"
            variant="default"
          >
            <Flex direction="column" gap="100">
              <Text elementType="h3">
                <strong>Lightning Fast</strong>
              </Text>
              <Text>
                Experience lightning-fast performance with our optimized
                platform. Built for speed and reliability, delivering results in
                milliseconds.
              </Text>
            </Flex>
          </Card>
          <Card
            asset={<IconHeadphones />}
            padding="600"
            direction="horizontal"
            variant="default"
          >
            <Flex direction="column" gap="100">
              <Text elementType="h3">
                <strong>Easy to Use</strong>
              </Text>
              <Text>
                Get started in minutes with our intuitive interface. No
                technical expertise required - designed for everyone to use
                effortlessly.
              </Text>
            </Flex>
          </Card>
          <Card
            asset={<IconShield />}
            padding="600"
            direction="horizontal"
            variant="default"
          >
            <Flex direction="column" gap="100">
              <Text elementType="h3">
                <strong>Secure & Safe</strong>
              </Text>
              <Text>
                Your data is protected with enterprise-grade security.
                Bank-level encryption and compliance standards keep everything
                safe.
              </Text>
            </Flex>
          </Card>
          <Card
            asset={<IconClock />}
            padding="600"
            direction="horizontal"
            variant="default"
          >
            <Flex direction="column" gap="100">
              <Text elementType="h3">
                <strong>24/7 Support</strong>
              </Text>
              <Text>
                Get help when you need it with our 24/7 customer support team.
                Expert assistance available via chat, email, or phone.
              </Text>
            </Flex>
          </Card>
          <Card
            asset={<IconDollarSign />}
            padding="600"
            direction="horizontal"
            variant="default"
          >
            <Flex direction="column" gap="100">
              <Text elementType="h3">
                <strong>Great Value</strong>
              </Text>
              <Text>
                Premium features at an affordable price. Flexible plans that
                scale with your needs and budget. No hidden fees or surprises.
              </Text>
            </Flex>
          </Card>
          <Card
            asset={<IconSettings />}
            padding="600"
            direction="horizontal"
            variant="default"
          >
            <Flex direction="column" gap="100">
              <Text elementType="h3">
                <strong>Advanced Features</strong>
              </Text>
              <Text>
                Stay ahead with cutting-edge features and regular updates.
                Advanced AI-powered tools that evolve with your business needs.
              </Text>
            </Flex>
          </Card>
        </Flex>
      </Flex>
    </Section>
  );
}
