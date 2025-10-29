import { Footer, Header } from "compositions";
import { AllProviders } from "data";
import { Demo } from "./examples/Demo";

function App() {
  return (
    <AllProviders>
      <Header />
      <Demo />
      <Footer />
    </AllProviders>
  );
}

export default App;
